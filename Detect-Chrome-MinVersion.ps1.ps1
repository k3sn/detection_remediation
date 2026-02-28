#detect-chrome-ps1
#Exit 0 = Installed and compliant 
#Exit 1 = Not compliant

$AppNamePattern = '*Google Chrome*'
$MinVersion = [version]'120.0.0.0'

$UninstallPaths = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

$LogDir = 'C:\ProgramData\ARCH'
$LogPath = Join-Path $LogDir 'Detect-Chrome-MinVersion.log'

if (-not (Test-Path -LiteralPath $LogDir)) {
    New-Item -Path $LogDir -ItemType Directory
    Write-Host "Folder created at $LogDir" -Verbose
} else {
    Write-Host "Folder already exists." -Verbose
}

function Write-Log($Message){   
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Line = "$Timestamp | $Message"
    $Line | Out-File -FilePath $LogPath -Append
}

Write-Log "Test log entry"





