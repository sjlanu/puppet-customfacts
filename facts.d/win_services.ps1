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
get-service | select DisplayName, Status | ForEach-Object {$factName = $_.DisplayName; $status = $_.Status; Write-Host winservice_$factName"="$status}
