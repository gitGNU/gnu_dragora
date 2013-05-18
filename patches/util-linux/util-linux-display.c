--- text-utils/display.c.orig	2012-09-20 10:16:51.000000000 -0300
+++ text-utils/display.c	2012-10-18 20:01:25.000000000 -0300
@@ -39,6 +39,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
 #include "hexdump.h"
 #include "xalloc.h"
 #include "c.h"
