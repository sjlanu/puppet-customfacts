# Get all installed software as indivual facts
# Fact: windowsSW_$factName
# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
$b = "c:\windows\temp\f6.txt"
$c = "c:\windows\temp\f7.txt"
Remove-Item $b -ErrorAction silentlycontinue
Remove-Item $c -ErrorAction silentlycontinue
Get-ItemProperty HKLM:\Software\wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | where{$_.DisplayName -and $_.displayname -notmatch 'Update'} | Select-Object DisplayName, DisplayVersion | ForEach-Object {$factName = $_.DisplayName -replace '([^a-z0-9)])', ''; $version = $_.DisplayVersion; add-content -Force -Encoding UTF8 $b $factName"="$version}
(get-content $b).Normalize([Text.NormalizationForm]::FormD) | set-content $b -Force -Encoding UTF8
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | where{$_.DisplayName -and $_.displayname -notmatch 'Update'} | Select-Object DisplayName, DisplayVersion | ForEach-Object {$factName = $_.DisplayName -replace '([^a-z0-9)])', ''; $version = $_.DisplayVersion; add-content -Force -Encoding UTF8 $c $factName"="$version}
(get-content $c).Normalize([Text.NormalizationForm]::FormD) | set-content $c -Force -Encoding UTF8
(get-content $c) | add-content $b -Force -Encoding UTF8
(get-content $b) | sort | set-content $b -Force -Encoding UTF8
(get-content $b) | foreach { 'windowsSW_' + $_ } | add-content $b -Force -Encoding UTF8
$b = get-content $b
foreach ($i in $b) {
write-output $i
}
