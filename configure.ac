dnl
dnl This is the configure.in for faad2 related to unix creation

dnl - libfaad.so
dnl - libmp4ff.a (only static for moment)
dnl - faad
dnl - xmms input mp4/aac plugin
dnl - mpeg4ip plugin (requires mpeg4ip's libmp4v2 to be installed)

AC_PREREQ(2.50)
AC_INIT(faad2, 2.8.8)
AC_CONFIG_AUX_DIR(.)
AM_INIT_AUTOMAKE([subdir-objects])

AC_PROG_LIBTOOL
AC_SUBST(LIBTOOL_DEPS)

dnl Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CPP
dnl disable for mpeg4ip plugin
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_CHECK_PROGS(RPMBUILD, rpmbuild, rpm)

AC_CONFIG_HEADERS([config.h])

AC_ARG_WITH(xmms,[  --with-xmms             compile XMMS-1 plugin],
	     WITHXMMS=$withval, WITHXMMS=no)

AC_ARG_WITH(drm,[  --with-drm              compile libfaad with DRM support],
	     WITHDRM=$withval, WITHDRM=no)

AC_ARG_WITH(mpeg4ip, [  --with-mpeg4ip          compile mpeg4ip plugin],
		     WITHMPEG4IP=$withval, WITHMPEG4IP=no)

dnl Checks for header files required for mp4.h
AC_HEADER_STDC
AC_CHECK_HEADERS(stdint.h inttypes.h)
AC_CHECK_HEADERS(mathf.h)
AC_CHECK_HEADERS(float.h)
AC_CHECK_FUNCS(strchr memcpy)
AC_CHECK_HEADERS(sys/time.h)
AC_HEADER_TIME

dnl DRMS 
AC_CHECK_HEADERS(errno.h sys/stat.h sys/types.h limits.h)
AC_CHECK_HEADERS(sysfs/libsysfs.h)
AC_CHECK_HEADERS(IOKit/IOKitLib.h,
  [AC_CHECK_LIB(IOKit, main,
    [AC_DEFINE(HAVE_IOKIT_IOKITLIB_H, 1, [Define if you have the IOKit API])
     MP4FF_LIBS="-lIOKit"
     AC_SUBST(MP4FF_LIBS)])])
AC_CHECK_FUNCS(getpwuid)

AC_C_INLINE
AC_C_BIGENDIAN

AC_TYPE_OFF_T

AC_DEFUN([MY_CHECK_TYPEDEF_FROM_INCLUDE],
[
   AC_MSG_CHECKING([for $1])
   AC_TRY_COMPILE([$2],
                  [$1;],
                  libfaad_ok=yes, libfaad_ok=no)
   if test $libfaad_ok = yes; then
      AC_DEFINE($3, 1, [Define if needed])
      AC_MSG_RESULT([yes])
   else
      AC_MSG_RESULT([no])
fi
])

dnl @synopsis AC_C99_FUNC_LRINTF
dnl
dnl Check whether C99's lrintf function is available.
dnl @version 1.3        Feb 12 2002
dnl @author Erik de Castro Lopo <erikd AT mega-nerd DOT com>
dnl
dnl Permission to use, copy, modify, distribute, and sell this file for any
dnl purpose is hereby granted without fee, provided that the above copyright
dnl and this permission notice appear in all copies.  No representations are
dnl made about the suitability of this software for any purpose.  It is
dnl provided "as is" without express or implied warranty.
dnl
AC_DEFUN([AC_C99_FUNC_LRINTF],
[AC_CACHE_CHECK(for lrintf,
  ac_cv_c99_lrintf,
[
lrintf_save_CFLAGS=$CFLAGS
CFLAGS="-O -lm"
AC_TRY_LINK([
#define         _ISOC9X_SOURCE  1
#define         _ISOC99_SOURCE  1
#define         __USE_ISOC99    1
#define         __USE_ISOC9X    1

#include <math.h>
], if (!lrintf(3.14159)) lrintf(2.7183);, ac_cv_c99_lrintf=yes, ac_cv_c99_lrintf=no)

CFLAGS=$lrintf_save_CFLAGS

])

if test "$ac_cv_c99_lrintf" = yes; then
  AC_DEFINE(HAVE_LRINTF, 1,
            [Define if you have C99's lrintf function.])
fi
])# AC_C99_FUNC_LRINTF
AC_C99_FUNC_LRINTF

MY_CHECK_TYPEDEF_FROM_INCLUDE([float32_t temp],
        [#include <sys/types.h>,
        #include <sys/float.h>], [HAVE_FLOAT32_T])

AC_CHECK_FUNCS(strsep)

AC_CHECK_PROG(external_mp4v2, mpeg4ip-config, yes, no)
AM_CONDITIONAL(HAVE_MPEG4IP_PLUG, false)
if test x$WITHMPEG4IP = xyes; then
   if test x$external_mp4v2 = xyes; then
      AM_CONDITIONAL(HAVE_MPEG4IP_PLUG, true)
      AC_MSG_NOTICE("Building MPEG4IP plugin")
   else
	AC_MSG_NOTICE("MPEG4IP libmp4v2 is required for MPEG4IP plugin")
   fi
fi

if test x$WITHXMMS = xyes; then
  AC_CHECK_PROGS(XMMS_CONFIG, xmms-config,"not_found")
  if test "$XMMS_CONFIG" = "not_found"; then
    AC_MSG_ERROR("*** xmms-config not found - xmms plugin can't be build")
  fi
  AC_CHECK_HEADER(pthread.h,,
           AC_MSG_ERROR(*** pthread headers support not installed or not found))
  AC_CHECK_HEADER(id3.h,,
       AC_MSG_ERROR(*** id3lib headers support not installed or not found))
  AC_CHECK_PROGS(GTK_CONFIG, gtk-config, "not_found")
  if test "$XGTK_CONFIG" = "not_found"; then
    AC_MSG_ERROR("*** gtk-config not found - xmms plugin can't be build without")
  fi

  AM_CONDITIONAL(HAVE_XMMS, true)
else
 AC_MSG_NOTICE(no xmms build configured)
 AM_CONDITIONAL(HAVE_XMMS, false)
fi

if test x$WITHDRM = xyes; then
  AC_DEFINE(DRM, 1, [Define if you want to use libfaad together with Digital Radio Mondiale (DRM)])
  AC_DEFINE(DRM_PS, 1, [Define if you want support for Digital Radio Mondiale (DRM) parametric stereo])
fi

AC_CONFIG_FILES(libfaad/Makefile)
AC_CONFIG_FILES(common/Makefile)
AC_CONFIG_FILES(common/mp4ff/Makefile)
AC_CONFIG_FILES(plugins/Makefile)
AC_CONFIG_FILES(plugins/xmms/Makefile)
AC_CONFIG_FILES(plugins/xmms/src/Makefile)
AC_CONFIG_FILES(plugins/mpeg4ip/Makefile)
AC_CONFIG_FILES(faad2.spec)
AC_CONFIG_FILES(faad2.pc)
AC_CONFIG_FILES(frontend/Makefile)
AC_CONFIG_FILES(Makefile)

AC_OUTPUT
