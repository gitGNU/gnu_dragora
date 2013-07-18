--- conf.mk.orig	2013-01-11 12:10:32.000000000 -0300
+++ conf.mk	2013-07-12 17:26:10.000000000 -0300
@@ -4,21 +4,24 @@
 # ===
 
 ## build configuration, standard gcc + libc:
-CC = gcc
-CFLAGS = -Wall -Wextra -Wshadow -DNDEBUG -O2
+#CC = gcc
+#CFLAGS = -Wall -Wextra -Wshadow -DNDEBUG -O2
 #CFLAGS = -Wall -Wextra -Wshadow -O2
 
 ## build configuration, dietlibc:
 #CC = diet -Os gcc
 #CFLAGS = -Wall -Wextra -Wshadow -DNDEBUG
 
+## build configuration, musl:
+CFLAGS = -Wall -Wextra -Wshadow -DNDEBUG -Os -static
+
 ## strip configuration
-STRIP = strip
+#STRIP = strip
 #STRIP = /some/other/stripper
 
 ## install configuration:
-BINDIR = /usr/bin
-SBINDIR = /usr/sbin
-MANDIR  = /usr/share/man
+BINDIR = /bin
+SBINDIR = /sbin
+MANDIR  = /share/man
 
 ### EOF (conf.mk)
