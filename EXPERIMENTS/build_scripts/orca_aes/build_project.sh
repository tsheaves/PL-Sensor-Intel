#!/bin/bash
if [[ -z "${QUARTUS_ROOTDIR}" ]]; then
  echo "QUARTUS_ROOTDIR environment variable not set!"
  exit
fi

# Create EV for IPs (some will not be included in the .ipx file)
BASEDIR=$(dirname $(realpath "$0"))
export QPROJ_IP=${BASEDIR}/../../../IP/

# Clear previous run
rm -rf "./${1}"
mkdir  "./${1}"
mkdir  "./${1}/work"

# Copy quartus project files & constraints to work directory
cp -rf ${BASEDIR}/../../quartus_projects/${1}/include_soc_files.tcl ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/*.qsf ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/*.qpf ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/*.v ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/*.sv ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/*.vhd ./work/
cp -rf ${BASEDIR}/../../quartus_projects/${1}/constraints ./work/constraints
cp -rf ${BASEDIR}/../../quartus_projects/${1}/flow_scripts ./work/flow_scripts

# Update IPX file - any changes to IP _hw.tcl files will be updated
${QUARTUS_ROOTDIR}/sopc_builder/bin/ip-make-ipx --source-directory=${QPROJ_IP} --output=./work/ips.ipx
cp -rf ${QPROJ_IP}/${1}_soc_system/soc_system.tcl ./work/soc_system.tcl

# Enter work directory
cd ./work

# Generate QSYS system - there should be as many QSYS builds as there are top-level QSYS IPs
${QUARTUS_ROOTDIR}/sopc_builder/bin/qsys-script --quartus-project=${1} --script=./soc_system.tcl

# Generate headers for QSYS systems - there should be as many header files as top-level QSYS IPs
mkdir system_headers
$QUARTUS_ROOTDIR/sopc_builder/bin/sopc-create-header-files ./soc_system.sopcinfo --output-dir qsys_headers --format h

# Compile project, per-module tool controls should be added to quartus project files
quartus_sh --flow compile ${1}
