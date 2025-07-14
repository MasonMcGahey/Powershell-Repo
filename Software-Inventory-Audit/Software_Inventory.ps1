# List all installed programs from both 32-bit and 64-bit registry paths
$programs = @()

# 64-bit installed programs
$programs += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* `
    | Select-Object DisplayName

# 32-bit installed programs (on 64-bit systems)
$programs += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
    | Select-Object DisplayName

# Filter out blank entries
$programs = $programs | Where-Object { $_.DisplayName }

# Output to screen
$programs | Sort-Object DisplayName | Format-Table -AutoSize

# Optional: Export to CSV for audit
$programs | Sort-Object DisplayName | Export-Csv -Path "\\ENFORCEMENT\IT Share\Audit Results\Software Audit Logs\$($env:COMPUTERNAME)_Installed_Software.csv" -NoTypeInformation

