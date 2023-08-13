#!/bin/bash
if [[ -z "${QUARTUS_ROOTDIR}" ]]; then
  echo "QUARTUS_ROOTDIR environment variable not set!"
  exit
fi

export QPROJ_IP="${PWD}/../../../IP/"

# Clear previous run
rm -rf "./${1}"
mkdir  "./${1}"
mkdir  "./${1}/work"

# Copy quartus project files/constraints to work directory
cp -rf ../../quartus_projects/${1}/include_soc_files.tcl ./work/
cp -rf ../../quartus_projects/${1}/*.qsf ./work/
cp -rf ../../quartus_projects/${1}/*.qpf ./work/
cp -rf ../../quartus_projects/${1}/*.v ./work/
cp -rf ../../quartus_projects/${1}/*.sv ./work/
cp -rf ../../quartus_projects/${1}/*.vhd ./work/
cp -rf ../../quartus_projects/${1}/constraints ./work/constraints
cp -rf ../../quartus_projects/${1}/flow_scripts ./work/flow_scripts

# Update IPX file - any changes in top-level IP directory will be resolved here
${QUARTUS_ROOTDIR}/sopc_builder/bin/ip-make-ipx --source-directory=${QPROJ_IP} --output=./work/ips.ipx
cp -rf ${QPROJ_IP}/${1}_soc_system/soc_system.tcl ./work/soc_system.tcl

cd ./work

# Generate SoC QSYS system - assumes we have a singule qsys IP at the top-level
${QUARTUS_ROOTDIR}/sopc_builder/bin/qsys-script --quartus-project=${1} --script=./soc_system.tcl

# Everything is ready, time to compile
quartus_sh --flow compile ${1}
