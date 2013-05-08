--- hints/linux.sh.orig	2013-03-04 12:16:22.000000000 -0300
+++ hints/linux.sh	2013-05-08 11:28:30.000000000 -0300
@@ -66,10 +66,7 @@
 # We don't use __GLIBC__ and  __GLIBC_MINOR__ because they
 # are insufficiently precise to distinguish things like
 # libc-2.0.6 and libc-2.0.7.
-if test -L /lib/libc.so.6; then
-    libc=`ls -l /lib/libc.so.6 | awk '{print $NF}'`
-    libc=/lib/$libc
-fi
+libc=${prefix}/lib/libc.a
 
 # Configure may fail to find lstat() since it's a static/inline
 # function in <sys/stat.h>.
@@ -167,11 +164,7 @@
 # we don't want its libraries. So we try to prefer the system gcc
 # Still, as an escape hatch, allow Configure command line overrides to
 # plibpth to bypass this check.
-if [ -x /usr/bin/gcc ] ; then
-    gcc=/usr/bin/gcc
-else
-    gcc=gcc
-fi
+gcc=gcc
 
 case "$plibpth" in
 '') plibpth=`LANG=C LC_ALL=C $gcc -print-search-dirs | grep libraries |
@@ -466,3 +459,8 @@
     libswanted="$libswanted pthread"
     ;;
 esac
+
+locincpth=""
+loclibpth=""
+glibpth="${prefix}/lib"
+usrinc="${prefix}/include"
