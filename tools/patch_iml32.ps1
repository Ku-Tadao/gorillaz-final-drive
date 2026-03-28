param(
    [Parameter(Position = 0)]
    [string]$Path = ".\IML32.dll",

    [switch]$SkipBackup
)

$ErrorActionPreference = "Stop"

function Find-PatternOffsets {
    param(
        [byte[]]$Data,
        [byte[]]$Pattern
    )

    $hits = New-Object System.Collections.Generic.List[int]

    for ($index = 0; $index -le $Data.Length - $Pattern.Length; $index++) {
        $matched = $true
        for ($patternIndex = 0; $patternIndex -lt $Pattern.Length; $patternIndex++) {
            if ($Data[$index + $patternIndex] -ne $Pattern[$patternIndex]) {
                $matched = $false
                break
            }
        }

        if ($matched) {
            $hits.Add($index)
        }
    }

    return $hits
}

function Replace-Pattern {
    param(
        [byte[]]$Data,
        [byte[]]$OldPattern,
        [byte[]]$NewPattern,
        [string]$Name
    )

    $offsets = Find-PatternOffsets -Data $Data -Pattern $OldPattern
    foreach ($offset in $offsets) {
        [Array]::Copy($NewPattern, 0, $Data, $offset, $NewPattern.Length)
    }

    Write-Host ("{0}: {1} replacement(s)" -f $Name, $offsets.Count)
    return $offsets.Count
}

if (-not (Test-Path -LiteralPath $Path)) {
    throw "IML32.dll not found: $Path"
}

$resolvedPath = (Resolve-Path -LiteralPath $Path).Path
$bytes = [System.IO.File]::ReadAllBytes($resolvedPath)

$pattern1Old = [byte[]](0x3D,0xFF,0xFF,0xFF,0x7F,0x72,0x05,0xB8,0xFF,0xFF,0xFF,0x7F)
$pattern1New = [byte[]](0x3D,0xFF,0xFF,0xFF,0x3F,0x72,0x05,0xB8,0xFF,0xFF,0xFF,0x3F)

$pattern2Old = [byte[]](0x3D,0xFF,0xFF,0xFF,0x7F,0x8B,0xD0,0x72,0x05,0xBA,0xFF,0xFF,0xFF,0x7F)
$pattern2New = [byte[]](0x3D,0xFF,0xFF,0xFF,0x3F,0x8B,0xD0,0x72,0x05,0xBA,0xFF,0xFF,0xFF,0x3F)

$pattern3Old = [byte[]](0x81,0xF9,0xFF,0xFF,0xFF,0x7F,0x72,0x05,0xB9,0xFF,0xFF,0xFF,0x7F)
$pattern3New = [byte[]](0x81,0xF9,0xFF,0xFF,0xFF,0x3F,0x72,0x05,0xB9,0xFF,0xFF,0xFF,0x3F)

$total = 0
$total += Replace-Pattern -Data $bytes -OldPattern $pattern1Old -NewPattern $pattern1New -Name "Pattern 1"
$total += Replace-Pattern -Data $bytes -OldPattern $pattern2Old -NewPattern $pattern2New -Name "Pattern 2"
$total += Replace-Pattern -Data $bytes -OldPattern $pattern3Old -NewPattern $pattern3New -Name "Pattern 3"

if ($total -eq 0) {
    Write-Warning "No matching patterns were found. The file may already be patched or may be a different build."
    exit 1
}

if (-not $SkipBackup) {
    $backupPath = "$resolvedPath.bak"
    if (-not (Test-Path -LiteralPath $backupPath)) {
        Copy-Item -LiteralPath $resolvedPath -Destination $backupPath
        Write-Host "Backup created: $backupPath"
    }
}

[System.IO.File]::WriteAllBytes($resolvedPath, $bytes)
Write-Host "Patched: $resolvedPath"
