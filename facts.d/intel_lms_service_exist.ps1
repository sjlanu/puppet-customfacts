# Intel Active Management Technology LMS Service existence and status
# factname: intel_lms_service_exist
# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
$srvName = 'lms'
if (get-service $srvName -ErrorAction SilentlyContinue) {write-output = "intel_lms_service_exist=True"}
else
{write-output = "intel_lms_service_exist=False"}
