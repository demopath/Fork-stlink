/*
 * File: gdb-remote.h
 *
 * Tool: st-util 
 */

#ifndef GDB_REMOTE_H
#define GDB_REMOTE_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#if defined(_WIN32)
#include <windows.h>
#include <winsock2.h>
#include <io.h>
#else
#include <poll.h>
#include <unistd.h>
#endif // _WIN32


int32_t gdb_send_packet(int32_t fd, char* data);
int32_t gdb_recv_packet(int32_t fd, char** buffer);
int32_t gdb_check_for_interrupt(int32_t fd);

#endif // GDB_REMOTE_H
