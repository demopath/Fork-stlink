/*
 * File: helper.h
 *
 * General helper functions
 */

#ifndef HELPER_H
#define HELPER_H

#ifdef STLINK_HAVE_SYS_TIME_H
#include <sys/time.h>
#else
#include <sys_time.h>
#endif // STLINK_HAVE_SYS_TIME_H

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>


uint32_t time_ms();
int32_t arg_parse_freq(const char *str);

#endif // HELPER_H
