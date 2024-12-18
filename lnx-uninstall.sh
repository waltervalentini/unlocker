#!/bin/bash
set -e

echo "Unlocker 3.0.2 for VMware Workstation"
echo "====================================="
echo "(c) Dave Parsons 2011-18"

# Ensure we only use unmodified commands
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo Restoring files...
base_dir=/usr/lib/vmware
backup_dir=./backup
cp -v \
  "$backup_dir/vmware-vmx" \
  "$backup_dir/vmware-vmx-debug" \
  "$backup_dir/vmware-vmx-stats" "$base_dir/bin"
if [ -d "$base_dir/lib/libvmwarebase.so.0/" ]; then
    cp -v "$backup_dir/libvmwarebase.so.0" "$base_dir/lib/libvmwarebase.so.0/"
elif [ -d "$base_dir/lib/libvmwarebase.so/" ]; then
    cp -v "$backup_dir/libvmwarebase.so" "$base_dir/lib/libvmwarebase.so/"
fi

echo Removing backup files...
rm -rf "$backup_dir" ./tools /usr/lib/vmware/isoimages/darwin*.*

echo Finished!
