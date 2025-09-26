Write-Host "Checking for Trivy installation..." -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# 1. Check Winget
if (Test-CommandExists winget) {
    $wingetResult = winget list | Select-String "trivy"
    if ($wingetResult) {
        Write-Host "Trivy found via Winget. Uninstalling..." -ForegroundColor Yellow
        winget uninstall trivy --silent
        return
    }
}

# 2. Check Chocolatey
if (Test-CommandExists choco) {
    $chocoResult = choco list --local-only | Select-String "trivy"
    if ($chocoResult) {
        Write-Host "Trivy found via Chocolatey. Uninstalling..." -ForegroundColor Yellow
        choco uninstall trivy -y
        return
    }
}

# 3. Check Scoop
if (Test-CommandExists scoop) {
    $scoopResult = scoop list | Select-String "trivy"
    if ($scoopResult) {
        Write-Host "Trivy found via Scoop. Uninstalling..." -ForegroundColor Yellow
        scoop uninstall trivy
        return
    }
}

# 4. Check Manual Installation (look in Program Files and PATH)
$possiblePaths = @(
    "$env:ProgramFiles\Trivy\trivy.exe",
    "$env:ProgramFiles\trivy.exe",
    "$env:USERPROFILE\scoop\apps\trivy\current\trivy.exe"
)

$found = $false
foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        Write-Host "Trivy binary found at $path. Removing..." -ForegroundColor Yellow
        Remove-Item $path -Force
        $found = $true
    }
}

if (-not $found) {
    Write-Host "Trivy not found in common locations. It may already be uninstalled." -ForegroundColor Green
} else {
    Write-Host "Trivy uninstalled successfully." -ForegroundColor Green
}
