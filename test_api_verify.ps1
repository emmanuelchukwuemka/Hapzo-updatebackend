$baseUrl = "https://hapztext-v2.onrender.com"

Write-Host "=== HAPZO API CONNECTION VERIFICATION ===" -ForegroundColor Cyan
Write-Host "Testing fixed endpoints at $baseUrl" -ForegroundColor Cyan
Write-Host ""

function Test-EP {
    param([string]$Label, [string]$Url, [string]$Method = "GET", [string]$Body = "")
    
    Write-Host "[$Method] $Label" -NoNewline
    try {
        $params = @{ Uri = $Url; Method = $Method; UseBasicParsing = $true; TimeoutSec = 60 }
        if ($Body -ne "" -and ($Method -eq "POST")) {
            $params.Body = $Body
            $params.ContentType = "application/json"
        }
        $resp = Invoke-WebRequest @params
        Write-Host " -> $($resp.StatusCode) OK" -ForegroundColor Green
        return @{ Code = $resp.StatusCode; OK = $true; Body = $resp.Content.Substring(0, [Math]::Min(200, $resp.Content.Length)) }
    } catch {
        $code = 0
        $body = ""
        if ($_.Exception.Response) {
            $code = [int]$_.Exception.Response.StatusCode
            try {
                $sr = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
                $body = $sr.ReadToEnd()
                $sr.Close()
            } catch {}
        }
        if ($code -ge 400 -and $code -lt 500) {
            Write-Host " -> $code (expected - endpoint exists)" -ForegroundColor Yellow
        } elseif ($code -ge 500) {
            Write-Host " -> $code SERVER ERROR" -ForegroundColor Red
        } else {
            Write-Host " -> UNREACHABLE: $($_.Exception.Message)" -ForegroundColor Red
        }
        return @{ Code = $code; OK = ($code -ge 400 -and $code -lt 500); Body = $body.Substring(0, [Math]::Min(200, $body.Length)) }
    }
}

Write-Host "`n--- Authentication Endpoints (FIXED: /authentication/) ---" -ForegroundColor Magenta
$r1 = Test-EP "Login /authentication/login/" "$baseUrl/api/v1/authentication/login/" "POST" '{"email":"test@test.com","password":"testpass"}'
$r2 = Test-EP "Register /authentication/register/" "$baseUrl/api/v1/authentication/register/" "POST" '{"email":"test@test.com","username":"testuser","password":"testpass","password_confirm":"testpass"}'
$r3 = Test-EP "Password Reset" "$baseUrl/api/v1/authentication/password-reset/" "POST" '{"email":"test@test.com"}'
$r4 = Test-EP "Verify Email" "$baseUrl/api/v1/authentication/verify-email/" "POST" '{"email":"test@test.com","otp_code":"000000"}'

Write-Host "`n--- User Endpoints ---" -ForegroundColor Magenta
$r5 = Test-EP "User Profile" "$baseUrl/api/v1/users/profile/1/"
$r6 = Test-EP "User Search" "$baseUrl/api/v1/users/search?query=test&limit=5&offset=1"
$r7 = Test-EP "Friends" "$baseUrl/api/v1/users/friends/1/30/"
$r8 = Test-EP "Create Profile" "$baseUrl/api/v1/users/profile/create/" "POST" '{}'

Write-Host "`n--- Post Endpoints ---" -ForegroundColor Magenta
$r9 = Test-EP "Post List" "$baseUrl/api/v1/posts/list/1/10/"
$r10 = Test-EP "Create Post" "$baseUrl/api/v1/posts/" "POST" '{"post_format":"text","text_content":"test","is_reply":false}'
$r11 = Test-EP "Post Comments" "$baseUrl/api/v1/posts/1/replies/1/30"

Write-Host "`n--- Chat Endpoints ---" -ForegroundColor Magenta
$r12 = Test-EP "Chat Conversations" "$baseUrl/api/v1/chat/conversations/1/20/"
$r13 = Test-EP "Create Conversation" "$baseUrl/api/v1/chat/conversations/" "POST" '{"participant_ids":["1"]}'
$r14 = Test-EP "Chat Media Upload" "$baseUrl/api/v1/chat/media/upload/" "POST" '{}'

Write-Host "`n--- Notifications ---" -ForegroundColor Magenta
$r15 = Test-EP "Notifications" "$baseUrl/api/v1/notifications/1/20/"

Write-Host "`n--- Old /auth/ path (should be 404 now that we fixed) ---" -ForegroundColor Magenta
$r16 = Test-EP "OLD /auth/register/ (expect 404)" "$baseUrl/api/v1/auth/register/" "POST" '{"email":"t@t.com","username":"t","password":"t"}'

Write-Host "`n`n=== SUMMARY ===" -ForegroundColor Cyan
$allResults = @($r1, $r2, $r3, $r4, $r5, $r6, $r7, $r8, $r9, $r10, $r11, $r12, $r13, $r14, $r15)
$working = ($allResults | Where-Object { $_.OK }).Count
$total = $allResults.Count
Write-Host "Endpoints responding: $working / $total" -ForegroundColor $(if ($working -eq $total) { "Green" } else { "Yellow" })
Write-Host "Old /auth/ path 404 confirmed: $(if ($r16.Code -eq 404) { 'YES (correct)' } else { 'NO' })" -ForegroundColor $(if ($r16.Code -eq 404) { "Green" } else { "Red" })
Write-Host ""
Write-Host "Response samples:" -ForegroundColor Gray
Write-Host "  Login response: $($r1.Body)" -ForegroundColor Gray
Write-Host "  Register response: $($r2.Body)" -ForegroundColor Gray
