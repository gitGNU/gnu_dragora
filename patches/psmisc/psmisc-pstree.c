--- src/pstree.c.orig	2012-09-19 10:05:43.000000000 -0300
+++ src/pstree.c	2012-10-22 12:56:16.000000000 -0300
@@ -49,7 +49,6 @@
 #include <selinux/selinux.h>
 #endif                                /*WITH_SELINUX */
 
-extern const char *__progname;
 
 #define PROC_BASE    "/proc"
 
@@ -912,7 +911,7 @@
     textdomain(PACKAGE);
 #endif
 
-    if (!strcmp(__progname, "pstree.x11"))
+    if (0)
         wait_end = 1;
 
     /*
