import os
import sys
import subprocess
from pathlib import Path

# Add the current directory to sys.path to ensure local modules are found
CURRENT_DIR = Path(__file__).resolve().parent
sys.path.append(str(CURRENT_DIR))

def ensure_venv():
    """
    Ensures the script runs within the project's virtual environment.
    If Django is not found, it attempts to re-execute using the .venv interpreter.
    """
    try:
        import django
        return # Django is available, we are good to go
    except ImportError:
        pass
    
    # Look for the virtual environment interpreter
    if os.name == "nt": # Windows
        venv_python = CURRENT_DIR / ".venv" / "Scripts" / "python.exe"
    else: # Linux/macOS
        venv_python = CURRENT_DIR / ".venv" / "bin" / "python"
        
    if venv_python.exists():
        # Avoid infinite recursion if the venv itself is broken
        if "RE_EXECUTED" in os.environ:
            print("[ERROR] Django not found even within the virtual environment.")
            print("[TIP] Run 'uv sync' or 'pip install -r requirements.txt' to install dependencies.")
            sys.exit(1)
            
        print(f"[INFO] Virtual environment detected. Re-executing with {venv_python}...")
        env = os.environ.copy()
        env["RE_EXECUTED"] = "1"
        # Using subprocess for better cross-platform behavior than os.execv in some cases
        try:
            result = subprocess.run([str(venv_python)] + sys.argv, env=env)
            sys.exit(result.returncode)
        except Exception as e:
            print(f"[ERROR] Failed to re-execute script: {e}")
            sys.exit(1)
    else:
        print("[ERROR] Django not found and .venv directory not detected.")
        print("[TIP] Ensure you are in the 'backend' directory and have initialized the environment.")
        sys.exit(1)

def setup_environment():
    """Sets up the Django environment."""
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")
    try:
        import django
        django.setup()
        print("[INFO] Django environment initialized.")
    except Exception as e:
        print(f"[ERROR] Failed to initialize Django: {e}")
        sys.exit(1)

def run_migrations():
    """Runs database migrations."""
    print("[INFO] Checking for database migrations...")
    try:
        subprocess.run([sys.executable, "manage.py", "migrate"], check=True)
        print("[SUCCESS] Migrations checked/completed.")
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] Migrations failed: {e}")

def start_server(host="0.0.0.0", port="8000"):
    """Starts the Daphne ASGI server."""
    print(f"[INFO] Starting Daphne server on http://{host}:{port}")
    try:
        # Daphne is used for ASGI/WebSocket support
        cmd = [
            sys.executable, "-m", "daphne",
            "-b", host,
            "-p", port,
            "config.asgi:application"
        ]
        subprocess.run(cmd)
    except KeyboardInterrupt:
        print("\n[INFO] Server stopped by user.")
    except Exception as e:
        print(f"[ERROR] Failed to start server: {e}")
        sys.exit(1)

def main():
    """Main entry point for the backend."""
    import argparse
    parser = argparse.ArgumentParser(description="Hapzo Backend Entry Point")
    parser.add_argument("--no-migrate", action="store_true", help="Skip running migrations on startup")
    parser.add_argument("--host", default="0.0.0.0", help="Host to bind (default: 0.0.0.0)")
    parser.add_argument("--port", default="8000", help="Port to bind (default: 8000)")
    
    args = parser.parse_args()

    # 1. Ensure we are in the right environment
    ensure_venv()

    # 2. Setup Django
    setup_environment()

    # 3. Handle migrations
    if not args.no_migrate:
        run_migrations()

    # 4. Start Server
    start_server(host=args.host, port=args.port)

if __name__ == "__main__":
    main()
