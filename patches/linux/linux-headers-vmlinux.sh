--- scripts/link-vmlinux.sh.orig	2012-10-12 17:50:59.000000000 -0300
+++ scripts/link-vmlinux.sh	2012-10-26 10:26:00.000000000 -0300
@@ -104,7 +104,7 @@
 }
 
 # Delete output files in case of error
-trap cleanup SIGHUP SIGINT SIGQUIT SIGTERM ERR
+trap cleanup SIGHUP SIGINT SIGQUIT SIGTERM
 cleanup()
 {
 	rm -f .old_version
