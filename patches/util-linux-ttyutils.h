--- include/ttyutils.h.orig	2012-09-20 10:16:51.000000000 -0300
+++ include/ttyutils.h	2012-10-18 12:34:21.000000000 -0300
@@ -11,6 +11,8 @@
 #define UL_TTY_KEEPCFLAGS	(1 << 1)
 #define UL_TTY_UTF8		(1 << 2)
 
+#include "ttydefaults.h"
+
 static inline void reset_virtual_console(struct termios *tp, int flags)
 {
 	/* Use defaults of <sys/ttydefaults.h> for base settings */
