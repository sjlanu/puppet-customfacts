# List all registered services as facts
# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
$OutPutEncoding = [ System.Text.Encoding]::UTF8
get-service | select DisplayName, Status | ForEach-Object {$factName = $_.DisplayName -replace '([^a-z0-9)])', ''; $status = $_.Status; Write-Host winservice_$factName"="$status}
