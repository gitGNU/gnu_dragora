--- lib/c-strtod.c.orig	2013-01-02 09:34:45.000000000 -0300
+++ lib/c-strtod.c	2013-08-13 16:37:20.000000000 -0300
@@ -77,7 +77,7 @@
       return 0; /* errno is set here */
     }
 
-  r = STRTOD_L (nptr, endptr, locale);
+  r = STRTOD (nptr, endptr);
 
 #else
 
