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

Write-Log "Script Starting"

try {
    $Entries = Get-ItemProperty -Path $UninstallPaths -ErrorAction Stop

    $ChromeEntry = $Entries | Where-Object {
            $_.DisplayName -like "*Google Chrome*"
    }
} Catch {
    Write-Log "Unexpected Error: $($_.Exception.Message)"
    Exit 1
}

if (-not $ChromeEntry) {
    Write-Log "Google Chrome not installed"
    exit 1
}

Write-Log "FOUND: $($ChromeEntry.DisplayName) | Publisher: $($ChromeEntry.Publisher) | Version: $($ChromeEntry.DisplayVersion)"
Write-Log "Installed version (raw): $($ChromeEntry.DisplayVersion)"

if ([version]$ChromeEntry.DisplayVersion -ge [version]$MinVersion) {
    Write-Log "Compliant"
    exit 0
} 
else {
    Write-Log "Outdated"
    exit 1
}








