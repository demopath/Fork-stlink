/*
 * File: gdb-server.h
 *
 * Tool: st-util 
 */

#ifndef GDB_SERVER_H
#define GDB_SERVER_H

#include <ctype.h>
#include <getopt.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>

#if defined(_MSC_VER)
#include <stdbool.h>
#define __attribute__(x)
#endif

#if defined(_WIN32)
#include <windows.h>
#else
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>
#endif // _WIN32

#include <stlink.h>
#include <stm32_register.h>

#include <chipid.h>
#include <common_flash.h>
#include <flash_loader.h>
#include <helper.h>
#include <logging.h>
#include <read_write.h>
#include <remote.h>
#include <usb.h>


#define STRINGIFY_inner(name) #name
#define STRINGIFY(name) STRINGIFY_inner(name)

#define DEFAULT_LOGGING_LEVEL 50
#define DEBUG_LOGGING_LEVEL 100
#define DEFAULT_GDB_LISTEN_PORT 4242

#endif // GDB_SERVER_H
