#! /bin/sh
#
# /etc/rc.d/rc.I
#
# Boot-time system initialization script.
#
# (#)1.00  2013-07-17 (MAF)
#
# Made for Dragora GNU/Linux-Libre version 3
# by Matias A. Fonzo, <selk@dragora.org>.
#
# Under the terms of the GNU General Public License.

PATH=/sbin:/bin

LC_ALL=C
export LC_ALL

echo "*** Mounting kernel-based file systems ..."
mount -v -n -o nosuid,noexec,nodev -t proc  proc  /proc
mount -v -n -o nosuid,noexec,nodev -t sysfs sysfs /sys

# Preparations to mount /run
if [ -d /run ] ; then
  if ! mountpoint -q /run ; then
    mount -v -n -o mode=0755 -t tmpfs tmpfs /run
  fi
fi

echo "*** File system being prepared for checks ..."
echo "These checks may take some time.  Please be patient."

# Make sure if the root filesystem is in read-only mode
if touch /readwritefs 2> /dev/null ; then
  rm -f /readwritefs
  echo "* Remounting root filesystem in read-only mode:"
  mount -v -n -o remount,ro /
fi

if [ ! -e /fastboot ] ; then
  if [ -r /forcefsck ] ; then
    forceOption=-f
  fi

  echo "*** Checking the root filesystem ..."
  fsck $forceOption -a -C /
  errorCode=$?

  if [ $errorCode -eq 2 ] || [ $errorCode -eq 3 ] ; then
    printf '%s\n' \
     "o---------------------CHECK FAILED----------------------o" \
     "An error occurred while the root filesystem was checked."  \
     ""                                                          \
     "The system should be rebooted."                            \
     ""                                                          \
     "ERROR CODE: $errorCode"                                    \
     "o-------------------------------------------------------o" \
     ""
    printf "press ENTER to reboot ... "
    read -r
    reboot -f -d
  fi

  if [ $errorCode -gt 3 ] && [ $errorCode -lt 16 ] ; then
    printf '%s\n' \
     "o---------------------CHECK FAILED----------------------o" \
     "An error occurred while the root filesystem was checked."  \
     ""                                                          \
     "This is your chance to repair the system manually."        \
     "For help, check the *fsck utilities according to"          \
     "your filesystem."                                          \
     ""                                                          \
     "Note:"                                                     \
     "  The system is currently mounted in read-only mode,"      \
     "  the operations should be performed in this mode."        \
     ""                                                          \
     "To remount the system in read-write mode, type:"           \
     ""                                                          \
     "mount -n -o remount,rw /"                                  \
     ""                                                          \
     "ERROR CODE: $errorCode"                                    \
     "o-------------------------------------------------------o" \
     ""
    PS1='Repair_me:\w# '
    export PS1
    sulogin
  fi

  if [ $errorCode -ge 16 ] ; then
    printf '%s\n' \
     "o----------------------WARNING----------------------o" \
     ""                                                      \
     "Unexpected fsck error (code $errorCode)"               \
     ""                                                      \
     "o---------------------------------------------------o" \
     ""
  fi

  unset errorCode
else
  echo "* /fastboot is present:  Dodging checkings."
fi

echo "*** Remounting root filesystem in read-write mode:"
mount -v -n -o remount,rw /

# In modern distributions /etc/mtab is a symlink to /proc/self/mounts
rm -f /etc/mtab*
ln -s /proc/self/mounts /etc/mtab

# Activate immediately possible swap partitions or swap files
echo "*** Activating swap device(s), if any ..."
swapon -v -a -e

# Check the rest of the file systems (non-root)
if [ ! -e /fastboot ] ; then
  echo "*** Checking file systems via /etc/fstab ..."
  fsck $forceOption -R -A -a -C -T

  unset forceOption
fi

# Kernel modules
echo "*** Probing new kernel modules ..."
depmod -A

echo "*** Mounting local file systems ..."
mount -v -a -t noproc,nosysfs,nodevpts,nocifs,nosmbfs,nonfs

# Seek and destroy temporary files
rm -rf /fastboot \
       /forcefsck \
       /etc/nologin \
       /tmp/.ICE-unix/* \
       /tmp/.X11-unix/* \
       /tmp/.*-ICE-* \
       /tmp/.Xauth* \
       /tmp/.X?-lock \
       /tmp/serverauth.*

# Recreate directories for the unix domain socket
mkdir -p -m 1777 /tmp/.ICE-unix /tmp/.X11-unix

# Sanitation of /tmp
chmod 1777 /tmp

# Initialize the random number generator
echo "/etc/random-seed:  Initializing random number generator ..."

touch /etc/random-seed
cat /etc/random-seed > /dev/urandom

# Set the default pool size
bytes=$(cat /proc/sys/kernel/random/poolsize 2> /dev/null) || bytes=2048;

# Save the seed file
dd if=/dev/urandom of=/etc/random-seed count=1 bs=$bytes 2> /dev/null
chmod 0600 /etc/random-seed

