--- libmisc/utmp.c.orig	2012-05-18 14:57:54.000000000 -0300
+++ libmisc/utmp.c	2013-07-03 05:26:37.000000000 -0300
@@ -41,6 +41,9 @@
 #include <utmpx.h>
 #endif
 
+#include <sys/socket.h>
+#include <netinet/in.h>
+
 #include <assert.h>
 #include <netdb.h>
 #include <stdio.h>
