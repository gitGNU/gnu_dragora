--- lib/fseterr.c.orig	2012-07-05 04:34:43.000000000 -0300
+++ lib/fseterr.c	2012-11-15 16:35:47.000000000 -0300
@@ -48,7 +48,7 @@
 #elif defined EPLAN9                /* Plan9 */
   if (fp->state != 0 /* CLOSED */)
     fp->state = 5 /* ERR */;
-#elif 0                             /* unknown  */
+#elif defined SLOW_BUT_NO_HACKS                             /* unknown  */
   /* Portable fallback, based on an idea by Rich Felker.
      Wow! 6 system calls for something that is just a bit operation!
      Not activated on any system, because there is no way to repair FP when
