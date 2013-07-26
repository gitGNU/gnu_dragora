#! /bin/sh
#
# /etc/rc.d/rc.S
#
# Single user mode script.
#
# (#)1.00  2013-07-23 (MAF)
#
# Made for Dragora GNU/Linux-Libre version 3
# by Matias A. Fonzo, <selk@dragora.org>.
#
# Under the terms of the GNU General Public License.

PATH=/sbin:/bin

echo "Sending the HUP signal to all process ..."
killall5 -1
sleep 5

echo "Sending the TERM signal to all process ..."
killall5 -15
sleep 7

echo "Switching to single user mode ..."
telinit 1

