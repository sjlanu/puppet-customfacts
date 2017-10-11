# Get all installed software as one fact (just for viewing), replace special characters from sw name.
# Fact: windows_AllInstalledSW
# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
$b = "c:\windows\temp\f2.txt"
$c = "c:\windows\temp\f3.txt"
Remove-Item $b -ErrorAction silentlycontinue
Remove-Item $c -ErrorAction silentlycontinue
Get-ItemProperty HKLM:\Software\wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | where{$_.DisplayName -and $_.displayname -notmatch 'Update'} | Select-Object DisplayName, DisplayVersion | ForEach-Object {$factName = $_.DisplayName -replace '([^a-z0-9)])', ''; $version = $_.DisplayVersion; add-content -Force -Encoding UTF8 $b $factName"="$version"="X86}
(get-content $b).Normalize([Text.NormalizationForm]::FormD) | set-content $b -Force -Encoding UTF8
(get-content $b) | foreach { $_ + ';' } | set-content $b -Force -Encoding UTF8

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | where{$_.DisplayName -and $_.displayname -notmatch 'Update'} | Select-Object DisplayName, DisplayVersion | ForEach-Object {$factName = $_.DisplayName -replace '([^a-z0-9)])', ''; $version = $_.DisplayVersion; add-content -Force -Encoding UTF8 $c $factName"="$version"="X64}
(get-content $c).Normalize([Text.NormalizationForm]::FormD) | set-content $c -Force -Encoding UTF8
(get-content $c) | foreach { $_ + ';' } | add-content $b -Force -Encoding UTF8
(get-content $b) | sort | set-content $b -Force -Encoding UTF8

$d = get-content $b
write-output = windows_AllInstalledSW"="$d
