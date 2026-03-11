$baseUrl = "http://72.62.4.119:8005"
$results = @()

function Test-Endpoint {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Method = "GET",
        [string]$Body = $null,
        [hashtable]$Headers = @{}
    )
    
    Write-Host "`n=== Testing: $Name ===" -ForegroundColor Cyan
    Write-Host "  URL: $Url"
    Write-Host "  Method: $Method"
    
    $result = @{
        Name = $Name
        Url = $Url
        Method = $Method
        Status = $null
        StatusCode = $null
        ResponsePreview = ""
        Error = ""
    }
    
    try {
        $params = @{
            Uri = $Url
            Method = $Method
            UseBasicParsing = $true
            TimeoutSec = 30
        }
        
        if ($Headers.Count -gt 0) {
            $params.Headers = $Headers
        }
        
        if ($Body -and ($Method -eq "POST" -or $Method -eq "PUT" -or $Method -eq "PATCH")) {
            $params.Body = $Body
            $params.ContentType = "application/json"
        }
        
        $response = Invoke-WebRequest @params
        $result.StatusCode = $response.StatusCode
        $result.Status = "SUCCESS"
        $bodyLen = $response.Content.Length
        if ($bodyLen -gt 300) {
            $result.ResponsePreview = $response.Content.Substring(0, 300) + "..."
        } else {
            $result.ResponsePreview = $response.Content
        }
        Write-Host "  Status: $($response.StatusCode) - SUCCESS" -ForegroundColor Green
        Write-Host "  Response: $($result.ResponsePreview)"
    }
    catch {
        $errMsg = $_.Exception.Message
        $result.Error = $errMsg
        
        if ($_.Exception.Response) {
            $statusCode = [int]$_.Exception.Response.StatusCode
            $result.StatusCode = $statusCode
            
            try {
                $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
                $errBody = $reader.ReadToEnd()
                $reader.Close()
                if ($errBody.Length -gt 300) {
                    $result.ResponsePreview = $errBody.Substring(0, 300) + "..."
                } else {
                    $result.ResponsePreview = $errBody
                }
            } catch {
                $result.ResponsePreview = "Could not read response body"
            }
            
            # 400/401/403/404 still means the server is REACHABLE and RESPONDING
            if ($statusCode -ge 400 -and $statusCode -lt 500) {
                $result.Status = "REACHABLE (Client Error)"
                Write-Host "  Status: $statusCode - REACHABLE (Client Error)" -ForegroundColor Yellow
            } elseif ($statusCode -ge 500) {
                $result.Status = "SERVER ERROR"
                Write-Host "  Status: $statusCode - SERVER ERROR" -ForegroundColor Red
            } else {
                $result.Status = "UNKNOWN"
                Write-Host "  Status: $statusCode" -ForegroundColor Red
            }
        } else {
            $result.StatusCode = "N/A"
            $result.Status = "UNREACHABLE"
            Write-Host "  Status: UNREACHABLE - $errMsg" -ForegroundColor Red
        }
        Write-Host "  Response: $($result.ResponsePreview)"
    }
    
    return $result
}

Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  Hapzo Backend API Test Suite" -ForegroundColor Magenta
Write-Host "  Server: $baseUrl" -ForegroundColor Magenta
Write-Host "  Time: $(Get-Date)" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta

# 1. Schema / Base connectivity
$results += Test-Endpoint -Name "Schema (Base Connectivity)" -Url "$baseUrl/schema/"

# 2. Auth endpoints - path A: /api/v1/authentication/
$results += Test-Endpoint -Name "Auth Login (authentication path)" -Url "$baseUrl/api/v1/authentication/login/" -Method "POST" -Body '{"username":"testuser","password":"testpass"}'

$results += Test-Endpoint -Name "Auth Register (authentication path)" -Url "$baseUrl/api/v1/authentication/register/" -Method "POST" -Body '{"email":"test@test.com","username":"testuser","password":"testpass"}'

$results += Test-Endpoint -Name "Password Reset (authentication path)" -Url "$baseUrl/api/v1/authentication/password-reset/" -Method "POST" -Body '{"email":"test@test.com"}'

$results += Test-Endpoint -Name "Verify Email (authentication path)" -Url "$baseUrl/api/v1/authentication/verify-email/" -Method "POST" -Body '{"token":"dummy"}'

$results += Test-Endpoint -Name "Verify Email Request (authentication path)" -Url "$baseUrl/api/v1/authentication/verify-email/request/" -Method "POST" -Body '{"email":"test@test.com"}'

# 3. Auth endpoints - path B: /api/v1/auth/
$results += Test-Endpoint -Name "Auth Login (auth path)" -Url "$baseUrl/api/v1/auth/login/" -Method "POST" -Body '{"username":"testuser","password":"testpass"}'

$results += Test-Endpoint -Name "Auth Register (auth path)" -Url "$baseUrl/api/v1/auth/register/" -Method "POST" -Body '{"email":"test@test.com","username":"testuser","password":"testpass"}'

# 4. User Profile endpoints (no auth token = should get 401/403)
$results += Test-Endpoint -Name "User Profile (no auth)" -Url "$baseUrl/api/v1/users/profile/1/" -Method "GET"

$results += Test-Endpoint -Name "User Search (no auth)" -Url "$baseUrl/api/v1/users/search?query=test&limit=5&offset=1" -Method "GET"

$results += Test-Endpoint -Name "User Friends (no auth)" -Url "$baseUrl/api/v1/users/friends/1/30/" -Method "GET"

$results += Test-Endpoint -Name "User Followers (no auth)" -Url "$baseUrl/api/v1/users/followers/1/1/20/" -Method "GET"

$results += Test-Endpoint -Name "User Followings (no auth)" -Url "$baseUrl/api/v1/users/followings/1/1/20/" -Method "GET"

$results += Test-Endpoint -Name "Create Profile (no auth)" -Url "$baseUrl/api/v1/users/profile/create/" -Method "POST" -Body '{}'

$results += Test-Endpoint -Name "Follow Request (no auth)" -Url "$baseUrl/api/v1/users/follow-request/1/" -Method "POST" -Body '{}'

$results += Test-Endpoint -Name "Pending Follow Requests (no auth)" -Url "$baseUrl/api/v1/users/follow-requests/pending/1/20/" -Method "GET"

# 5. Post endpoints (no auth token)
$results += Test-Endpoint -Name "Post List (no auth)" -Url "$baseUrl/api/v1/posts/list/1/10/" -Method "GET"

$results += Test-Endpoint -Name "Create Post (no auth)" -Url "$baseUrl/api/v1/posts/" -Method "POST" -Body '{"content":"test"}'

$results += Test-Endpoint -Name "Post Comments (no auth)" -Url "$baseUrl/api/v1/posts/1/replies/1/30" -Method "GET"

# 6. Chat endpoints (no auth token)
$results += Test-Endpoint -Name "Chat Conversations (no auth)" -Url "$baseUrl/api/v1/chat/conversations/1/20/" -Method "GET"

$results += Test-Endpoint -Name "Create Conversation (no auth)" -Url "$baseUrl/api/v1/chat/conversations/" -Method "POST" -Body '{"participant_ids":["1"]}'

$results += Test-Endpoint -Name "Chat Media Upload (no auth)" -Url "$baseUrl/api/v1/chat/media/upload/" -Method "POST" -Body '{}'

# 7. Notification endpoints (no auth)
$results += Test-Endpoint -Name "Notifications (no auth)" -Url "$baseUrl/api/v1/notifications/1/20/" -Method "GET"

# 8. WebSocket test (just check if the upgrade endpoint exists)
$results += Test-Endpoint -Name "WebSocket Endpoint (HTTP probe)" -Url "$baseUrl/ws/chat/test-conv/?token=dummytoken" -Method "GET"

Write-Host "`n`n============================================" -ForegroundColor Magenta
Write-Host "  SUMMARY" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta

foreach ($r in $results) {
    $color = "White"
    if ($r.Status -eq "SUCCESS") { $color = "Green" }
    elseif ($r.Status -like "*Client Error*") { $color = "Yellow" }
    elseif ($r.Status -eq "SERVER ERROR") { $color = "Red" }
    elseif ($r.Status -eq "UNREACHABLE") { $color = "DarkRed" }
    
    Write-Host "  [$($r.StatusCode)] $($r.Name) - $($r.Status)" -ForegroundColor $color
}

# Output JSON for parsing
$jsonOutput = $results | ConvertTo-Json -Depth 5
$jsonOutput | Out-File -FilePath "test_api_results.json" -Encoding UTF8
Write-Host "`nResults saved to test_api_results.json" -ForegroundColor Green
