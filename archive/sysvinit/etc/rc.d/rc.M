#! /bin/sh
#
# /etc/rc.d/rc.M
#
# Multiuser mode script.
#
# (#)1.00  2013-07-24 (MAF)
#
# Made for Dragora GNU/Linux-Libre version 3
# by Matias A. Fonzo, <selk@dragora.org>.
#
# Under the terms of the GNU General Public License.

LC_ALL=C
export LC_ALL

echo "Entering to the multiuser mode ..."

# Start the rc.local script
if [ -x /etc/rc.d/rc.local ] ; then
  echo "* Running /etc/rc.d/rc.local ..."
  . /etc/rc.d/rc.local
fi

