#!/bin/bash
if [[ -z "${QUARTUS_ROOTDIR}" ]]; then
  echo "QUARTUS_ROOTDIR environment variable not set!"
else
  ${QUARTUS_ROOTDIR}/sopc_builder/bin/ip-make-ipx --source-directory=$1 --output=$2
fi
