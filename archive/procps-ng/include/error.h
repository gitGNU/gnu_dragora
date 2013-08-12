#include <stdio.h>
#include <string.h>
#define HAVE_PROGRAM_INVOCATION_SHORT_NAME
#define PROGRAM_NAME "procps"

#define error(status, errnum, ...) \
  do { fflush(stdout); \
       dprintf(2, PROGRAM_NAME ": "); \
       dprintf(2, __VA_ARGS__); \
       if(errnum) dprintf(2, ": %s", strerror(errnum)); \
       dprintf(2, "\n"); \
       if(status) exit(status); \
     } while(0)
                                       
#define error_at_line(status, errnum, fn, line, ...) \
  do { fflush(stdout); \
       dprintf(2, PROGRAM_NAME ": %s:%d", fn, (int) line); \
       dprintf(2, __VA_ARGS__); \
       if(errnum) dprintf(2, ": %s", strerror(errnum)); \
       dprintf(2, "\n"); \
       if(status) exit(status); \
     } while(0)

