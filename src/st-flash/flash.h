/*
 * File: flash.h
 *
 * Tool: st-flash 
 */

#ifndef FLASH_H
#define FLASH_H

#include <fcntl.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(_WIN32)
#else
#include <unistd.h>
#endif // _WIN32

#include <stlink.h>
#include <stm32.h>

#include <chipid.h>
#include <common_flash.h>
#include <map_file.h>
#include <option_bytes.h>
#include <remote.h>
#include <usb.h>


#define DEBUG_LOG_LEVEL 100
#define STND_LOG_LEVEL  50
#define ENABLE_OPT      1

// static stlink_t *connected_stlink = NULL;
// static void cleanup(int32_t signum);
// static void usage(void);

#endif // FLASH_H
