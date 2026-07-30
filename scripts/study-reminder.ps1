# study-reminder.ps1
# 杭州事业编备考学习提醒 - 通过 Server酱 推送到微信
param(
    [Parameter(Mandatory=$true)]
    [string]$Title,
    [Parameter(Mandatory=$true)]
    [string]$Message
)

$sendKey = "SCT387037TZ0UdTleEowQ61PNnovkHzRcW"
$url = "https://sctapi.ftqq.com/$sendKey.send"

$body = @{
    title = $Title
    desp  = $Message
}

try {
    $result = Invoke-RestMethod -Uri $url -Method Post -Body $body -ContentType "application/x-www-form-urlencoded"
    if ($result.code -eq 0) {
        Write-Host "[OK] Sent: $Title"
    } else {
        Write-Host "[FAIL] $($result.message)"
    }
} catch {
    Write-Host "[ERROR] $_"
}