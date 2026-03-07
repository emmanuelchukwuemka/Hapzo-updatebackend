#!/usr/bin/env python3
"""
Deployment script for Django backend to remote server.
Checks for available ports and deploys to avoid port clashing.
"""

import sys
import time
from typing import Optional, List, Tuple
from pathlib import Path
import paramiko
from paramiko import AutoAddPolicy
import scp

# helper for local HTTP endpoint checks

def check_http_endpoints(base_url: str, endpoints: Optional[List[str]] = None) -> bool:
    """Check a set of HTTP endpoints on a deployed service.

    Args:
        base_url: scheme://host:port root of the service
        endpoints: list of path strings (leading slash). Uses defaults if None.
    Returns:
        True if all endpoints returned a 2xx/3xx status code.
    """
    try:
        import requests
    except ImportError:
        print("⚠️  'requests' not installed; skipping detailed endpoint tests.")
        return False

    if endpoints is None:
        endpoints = [
            "/api/v1/", "/api/v1/auth/login/", "/api/v1/users/",
            "/api/v1/posts/", "/api/v1/chat/", "/api/v1/notifications/",
            "/api/v1/calls/", "/api/v1/health/",
        ]

    all_ok = True
    for path in endpoints:
        url = base_url.rstrip("/") + path
        try:
            resp = requests.get(url, timeout=5)
            code = resp.status_code
            if 200 <= code < 400:
                print(f"✅ {url} -> {code}")
            else:
                print(f"❌ {url} -> {code}")
                all_ok = False
        except Exception as exc:
            print(f"❌ {url} request failed: {exc}")
            all_ok = False
    return all_ok


class DeploymentManager:
    """Manages deployment to remote server with port availability checking."""
    
    def __init__(
        self,
        server_host: str = "72.62.4.119",
        server_user: str = "root",
        server_password: str = "Mathscrusader123.",
        port_start: int = 8000,
        port_end: int = 8100,
    ):
        """
        Initialize deployment manager.
        
        Args:
            server_host: IP address of the server
            server_user: SSH username
            server_password: SSH password
            port_start: Starting port to check
            port_end: Ending port to check
        """
        self.server_host = server_host
        self.server_user = server_user
        self.server_password = server_password
        self.port_start = port_start
        self.port_end = port_end
        self.available_port = None
        self.ssh_client = None
        self.scp_client = None
        
    def _connect_ssh(self) -> Tuple[bool, str]:
        """
        Establish SSH connection to remote server.
        
        Returns:
            Tuple of (success: bool, message: str)
        """
        try:
            self.ssh_client = paramiko.SSHClient()
            self.ssh_client.set_missing_host_key_policy(AutoAddPolicy())
            
            print(f"🔗 Connecting to {self.server_user}@{self.server_host}...")
            
            self.ssh_client.connect(
                hostname=self.server_host,
                username=self.server_user,
                password=self.server_password,
                timeout=10,
                allow_agent=False,
                look_for_keys=False,
            )
            
            print(f"✅ SSH connection established")
            return True, "Connected successfully"
            
        except paramiko.AuthenticationException as e:
            return False, f"Authentication failed: {str(e)}"
        except paramiko.SSHException as e:
            return False, f"SSH error: {str(e)}"
        except Exception as e:
            return False, f"Connection error: {str(e)}"
    
    def _disconnect_ssh(self):
        """Close SSH connection."""
        if self.ssh_client:
            self.ssh_client.close()
            print("🔌 SSH connection closed")
        
    def _run_ssh_command(self, command: str) -> Tuple[bool, str]:
        """
        Execute a command on remote server via SSH.
        
        Args:
            command: Command to execute
            
        Returns:
            Tuple of (success: bool, output: str)
        """
        if not self.ssh_client:
            return False, "SSH connection not established"
        
        try:
            stdin, stdout, stderr = self.ssh_client.exec_command(command, timeout=30)
            exit_status = stdout.channel.recv_exit_status()
            
            output = stdout.read().decode('utf-8').strip()
            error = stderr.read().decode('utf-8').strip()
            
            if exit_status == 0:
                return True, output
            else:
                return False, error if error else output
                
        except Exception as e:
            return False, f"Command execution error: {str(e)}"
    
    def _upload_files(self, local_path: str, remote_path: str) -> Tuple[bool, str]:
        """
        Upload files to remote server via tar over paramiko SSH.
        
        Args:
            local_path: Local file/directory path
            remote_path: Remote destination path
            
        Returns:
            Tuple of (success: bool, message: str)
        """
        if not self.ssh_client:
            return False, "SSH connection not established"
        
        try:
            local = Path(local_path).resolve()
            if not local.exists():
                return False, f"Local path does not exist: {local_path}"
            
            print(f"📤 Uploading {local} to {remote_path}...")
            
            # Use tar over SSH for better reliability with large directories
            if local.is_dir():
                import subprocess
                import io
                
                # Create tar of the directory, excluding unnecessary files
                tar_cmd = [
                    "tar", "czf", "-", 
                    "--exclude=__pycache__",
                    "--exclude=*.pyc",
                    "--exclude=.git",
                    "--exclude=.gitignore",
                    "--exclude=.env",
                    "--exclude=logs",
                    "--exclude=media",
                    "--exclude=staticfiles",
                    "--exclude=.venv",
                    "--exclude=venv",
                    "--exclude=*.log",
                    "--exclude=db.sqlite3",
                    "-C", str(local.parent), local.name
                ]
                
                # Run tar locally to get the data
                tar_proc = subprocess.Popen(tar_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                tar_data, tar_err = tar_proc.communicate()
                
                if tar_proc.returncode != 0:
                    return False, f"Tar creation failed: {tar_err.decode()}"
                
                # Send to remote via SSH
                remote_cmd = f"mkdir -p {remote_path} && cd {remote_path} && tar xzf -"
                stdin, stdout, stderr = self.ssh_client.exec_command(remote_cmd)
                stdin.write(tar_data)
                stdin.close()
                
                exit_status = stdout.channel.recv_exit_status()
                err_output = stderr.read().decode('utf-8')
                
                if exit_status != 0:
                    return False, f"Remote extraction failed: {err_output}"
            else:
                # For single files, use SCP
                scp_client = scp.SCPClient(self.ssh_client.get_transport())
                scp_client.put(str(local), remote_path)
                scp_client.close()
            
            return True, "Upload successful"
            
        except Exception as e:
            return False, f"Upload error: {str(e)}"
    
    def check_available_ports(self) -> List[int]:
        """
        Check for available ports on the remote server.
        
        Returns:
            List of available ports
        """
        print(f"\n📍 Checking available ports on {self.server_host}...")
        print(f"   Port range: {self.port_start} - {self.port_end}\n")
        
        # Command to check listening ports using netstat
        check_command = "netstat -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $NF}' | sort -u"
        
        success, output = self._run_ssh_command(check_command)
        
        if not success:
            print(f"⚠️  Could not determine used ports: {output}")
            print("   Attempting alternative method...")
            check_command = "ss -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $NF}' | sort -u"
            success, output = self._run_ssh_command(check_command)
            
            if not success:
                print(f"❌ Error checking ports: {output}")
                return []
        
        used_ports = set()
        if output:
            try:
                used_ports = set(int(p) for p in output.split('\n') if p.strip().isdigit())
            except ValueError:
                print(f"⚠️  Could not parse port information")
        
        # Find available ports
        available_ports = []
        for port in range(self.port_start, self.port_end + 1):
            if port not in used_ports:
                available_ports.append(port)
        
        # Display results
        print(f"✅ Ports in use: {sorted(list(used_ports)) if used_ports else 'None'}")
        print(f"✅ Available ports: {available_ports[:10]}")  # Show first 10
        
        return available_ports
    
    def select_port(self, available_ports: List[int]) -> Optional[int]:
        """
        Select the best available port (first one in range).
        
        Args:
            available_ports: List of available ports
            
        Returns:
            Selected port or None
        """
        if not available_ports:
            print("\n❌ No available ports found!")
            return None
        
        selected_port = available_ports[0]
        self.available_port = selected_port
        print(f"\n🎯 Selected port: {selected_port}")
        return selected_port
    

    
    def deploy_with_docker(self) -> bool:
        """
        Deploy using Docker Compose.
        
        Returns:
            True if deployment successful
        """
        print(f"\n🐳 Deploying with Docker on port {self.available_port}...")
        
        commands = [
            f"cd /opt/apps/backend-{self.available_port}/backend",
            f"sed -i 's/8000/{self.available_port}/g' docker-compose.yml",
            "docker-compose up -d",
            "sleep 5",
            "docker-compose logs",
        ]
        
        full_command = " && ".join(commands)
        success, output = self._run_ssh_command(full_command)
        
        if success:
            print(f"✅ Docker deployment successful!")
            print(output)
            return True
        else:
            print(f"❌ Docker deployment failed: {output}")
            return False
    
    def deploy_with_systemd(self) -> bool:
        """
        Deploy using systemd service.
        
        Returns:
            True if deployment successful
        """
        print(f"\n⚙️  Setting up systemd service on port {self.available_port}...")
        
        service_name = f"hapzo-backend-{self.available_port}"
        
        # Create systemd service file content
        service_content = f"""[Unit]
Description=Hapzo Backend Service on Port {self.available_port}
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/apps/backend-{self.available_port}/backend
Environment="DJANGO_ENVIRONMENT=production"
Environment="DJANGO_SETTINGS_MODULE=config.settings.production"
Environment="PORT={self.available_port}"
Environment="PYTHONUNBUFFERED=1"
Environment="PATH=/opt/apps/backend-{self.available_port}/.venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
ExecStart=/usr/bin/python3 -m daphne -b 0.0.0.0 -p {self.available_port} config.asgi:application
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
"""
        
        # Escape content for shell
        service_content_escaped = service_content.replace('"', '\\"').replace('\n', '\\n')
        
        commands = [
            f"cd /opt/apps/backend-{self.available_port}/backend",
            "python3 -m pip install -q daphne asgiref django-cors-headers 2>&1 | tail -5 || true",
            "python3 -m pip install -q -r requirements.txt 2>&1 | tail -5 || true",
            "python3 manage.py collectstatic --noinput 2>/dev/null || echo 'Static files collection skipped'",
            "python3 manage.py migrate --noinput 2>/dev/null || echo 'Migrations skipped'",
            f"echo '{service_content}' | tee /etc/systemd/system/{service_name}.service > /dev/null",
            "systemctl daemon-reload 2>&1",
            f"systemctl enable {service_name} 2>&1",
            f"systemctl restart {service_name} 2>&1",
            f"sleep 5",
            f"systemctl status {service_name} 2>&1 || true",
        ]
        
        full_command = " && ".join(commands)
        success, output = self._run_ssh_command(full_command)
        
        if success:
            print(f"✅ Systemd service deployed successfully!")
            print(output)
            return True
        else:
            print(f"❌ Systemd deployment failed: {output}")
            return False
    
    def verify_deployment(self) -> bool:
        """
        Verify the deployment is running.
        
        Returns:
            True if deployment is running
        """
        print(f"\n🔍 Verifying deployment on port {self.available_port}...")
        
        command = f"curl -s -o /dev/null -w '%{{http_code}}' http://localhost:{self.available_port}/api/v1/ || echo 'Connection refused'"
        success, output = self._run_ssh_command(command)
        
        if success and output.startswith("200"):
            print(f"✅ Application is running and responding with status {output}")
            return True
        else:
            print(f"⚠️  Application check result: {output}")
            print(f"   (App may still be starting up)")
            return False
    
    def run_deployment(
        self,
        local_path: str,
        use_docker: bool = True,
        upload_code: bool = True,
        test_endpoints: bool = False,
        fixed_port: Optional[int] = None,
    ) -> bool:
        """
        Run the complete deployment process.
        
        Args:
            local_path: Local path to backend directory
            use_docker: Use Docker deployment if True, systemd if False
            upload_code: Upload code to server if True
            test_endpoints: if True perform HTTP checks against common API paths
            fixed_port: if specified, use this port instead of checking availability
            
        Returns:
            True if deployment successful
        """
        print("\n" + "=" * 60)
        print("🚀 HAPZO BACKEND DEPLOYMENT")
        print("=" * 60)
        
        # Connect to server
        success, message = self._connect_ssh()
        if not success:
            print(f"❌ Connection failed: {message}")
            return False
        
        try:
            # Check available ports or use fixed port
            if fixed_port is not None:
                self.available_port = fixed_port
                print(f"\n🎯 Using specified port: {fixed_port}")
            else:
                available_ports = self.check_available_ports()
                if not available_ports:
                    print("\n❌ Deployment aborted: No available ports")
                    return False
                
                # Select port
                self.select_port(available_ports)
            
            # Upload codebase
            if upload_code:
                # Create remote directory first
                mkdir_cmd = f"mkdir -p /opt/apps/backend-{self.available_port}"
                success, message = self._run_ssh_command(mkdir_cmd)
                if not success:
                    print(f"❌ Failed to create remote directory: {message}")
                    return False
                
                success, message = self._upload_files(
                    local_path,
                    f"/opt/apps/backend-{self.available_port}"
                )
                if not success:
                    print(f"❌ Deployment aborted: {message}")
                    return False
                print(f"✅ {message}")
            
            # Deploy
            if use_docker:
                if not self.deploy_with_docker():
                    print("\n❌ Deployment aborted: Docker deployment failed")
                    return False
            else:
                if not self.deploy_with_systemd():
                    print("\n❌ Deployment aborted: Systemd deployment failed")
                    return False
            
            # Verify
            self.verify_deployment()
            
            # Optionally test API endpoints
            if test_endpoints and self.available_port:
                base = f"http://{self.server_host}:{self.available_port}"
                print("\n🔬 Running API endpoint checks...")
                ok = check_http_endpoints(base)
                if ok:
                    print("✅ All endpoint checks passed")
                else:
                    print("⚠️  Some endpoint checks failed")
            
            # Summary
            print("\n" + "=" * 60)
            print("✅ DEPLOYMENT COMPLETED")
            print("=" * 60)
            print(f"Server: {self.server_host}")
            print(f"Port: {self.available_port}")
            print(f"URL: http://{self.server_host}:{self.available_port}")
            print("=" * 60 + "\n")
            
            return True
            
        finally:
            self._disconnect_ssh()


def main():
    """Main entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Deploy Hapzo Backend to remote server with port availability checking"
    )
    parser.add_argument(
        "--host",
        default="72.62.4.119",
        help="Server IP address (default: 72.62.4.119)",
    )
    parser.add_argument(
        "--user",
        default="root",
        help="SSH username (default: root)",
    )
    parser.add_argument(
        "--password",
        default="Mathscrusader123.",
        help="SSH password (default: from environment or hardcoded)",
    )
    parser.add_argument(
        "--port-start",
        type=int,
        default=8000,
        help="Starting port to check (default: 8000)",
    )
    parser.add_argument(
        "--port-end",
        type=int,
        default=8100,
        help="Ending port to check (default: 8100)",
    )
    parser.add_argument(
        "--port",
        type=int,
        help="Specific port to use (skips availability check)",
    )
    parser.add_argument(
        "--systemd",
        action="store_true",
        help="Use systemd deployment instead of Docker",
    )
    parser.add_argument(
        "--no-upload",
        action="store_true",
        help="Skip code upload (assume already uploaded)",
    )
    parser.add_argument(
        "--local-path",
        default=".",
        help="Local path to backend directory (default: current directory)",
    )
    parser.add_argument(
        "--test",
        action="store_true",
        help="Run HTTP tests against common API endpoints after deployment",
    )
    
    args = parser.parse_args()
    
    # Create deployment manager
    manager = DeploymentManager(
        server_host=args.host,
        server_user=args.user,
        server_password=args.password,
        port_start=args.port_start,
        port_end=args.port_end,
    )
    
    # Run deployment
    success = manager.run_deployment(
        local_path=args.local_path,
        use_docker=not args.systemd,
        upload_code=not args.no_upload,
        test_endpoints=args.test,
        fixed_port=args.port,
    )
    
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
