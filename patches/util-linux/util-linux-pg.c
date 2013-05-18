--- text-utils/pg.c.orig	2012-09-20 10:16:51.000000000 -0300
+++ text-utils/pg.c	2012-10-18 20:05:00.000000000 -0300
@@ -37,7 +37,7 @@
 #ifndef	TIOCGWINSZ
 #include <sys/ioctl.h>
 #endif
-#include <sys/termios.h>
+#include <termios.h>
 #include <fcntl.h>
 #include <regex.h>
 #include <stdio.h>
