# Findlibusb.cmake
# Modern CMake 3.20+ Find module for libusb-1.0
# Defines:
#   - Imported Target: libusb::libusb

include(FetchContent)
include(FindPackageHandleStandardArgs)

set(LIBUSB_FOUND FALSE)

# FreeBSD: libusb is integrated into the system
if(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    find_path(LIBUSB_INCLUDE_DIR NAMES libusb.h HINTS /usr/include)
    find_library(LIBUSB_LIBRARY NAMES usb HINTS /usr /usr/local /opt)

    if(LIBUSB_INCLUDE_DIR AND LIBUSB_LIBRARY)
        set(LIBUSB_FOUND TRUE)
        if(NOT TARGET libusb::libusb)
            add_library(libusb::libusb UNKNOWN IMPORTED GLOBAL)
            set_target_properties(libusb::libusb PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${LIBUSB_INCLUDE_DIR}"
                IMPORTED_LOCATION "${LIBUSB_LIBRARY}"
            )
        endif()
    endif()

# OpenBSD: libusb is available from ports
elseif(CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
    find_path(LIBUSB_INCLUDE_DIR NAMES libusb.h HINTS /usr/local/include PATH_SUFFIXES libusb-1.0)
    find_library(LIBUSB_LIBRARY NAMES usb-1.0 HINTS /usr/local)

    if(LIBUSB_INCLUDE_DIR AND LIBUSB_LIBRARY)
        set(LIBUSB_FOUND TRUE)
        if(NOT TARGET libusb::libusb)
            add_library(libusb::libusb UNKNOWN IMPORTED GLOBAL)
            set_target_properties(libusb::libusb PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${LIBUSB_INCLUDE_DIR}"
                IMPORTED_LOCATION "${LIBUSB_LIBRARY}"
            )
        endif()
    endif()

# Windows, MSVC, or MinGW (including Cross-Compiling from Linux/macOS)
elseif(WIN32 OR MSVC OR MINGW)
    # Fix for ssize_t on Windows
    add_compile_definitions(_SSIZE_T_DEFINED ssize_t=int64_t)

    # 1. Try to find an already installed local Windows version of libusb
    find_path(LIBUSB_INCLUDE_DIR
        NAMES libusb.h
        HINTS "C:/Program Files/libusb-1.0/include" "C:/Program Files (x86)/libusb-1.0/include"
        PATH_SUFFIXES libusb-1.0
    )

    find_library(LIBUSB_LIBRARY
        NAMES usb-1.0 libusb-1.0
        HINTS "C:/Program Files/libusb-1.0" "C:/Program Files (x86)/libusb-1.0"
    )

    if(LIBUSB_INCLUDE_DIR AND LIBUSB_LIBRARY)
        set(LIBUSB_FOUND TRUE)
        if(NOT TARGET libusb::libusb)
            add_library(libusb::libusb UNKNOWN IMPORTED GLOBAL)
            set_target_properties(libusb::libusb PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${LIBUSB_INCLUDE_DIR}"
                IMPORTED_LOCATION "${LIBUSB_LIBRARY}"
            )
        endif()
    endif()

    # 2. Modern FetchContent logic for Cross-Compiling (e.g. Debian host)
    if(NOT LIBUSB_FOUND)
        message(STATUS "libusb-1.0 not found locally. Downloading and building from source via FetchContent...")

        FetchContent_Declare(
            libusb
            GIT_REPOSITORY "https://github.com/libusb/libusb.git"
            GIT_TAG "v1.0.30"
        )
        FetchContent_MakeAvailable(libusb)

        # Alias the internal target from libusb-cmake to our standard namespaced target
        if(TARGET libusb-1.0 AND NOT TARGET libusb::libusb)
            add_library(libusb::libusb ALIAS libusb-1.0)
            set(LIBUSB_FOUND TRUE)
        endif()
    endif()

# All other Unix-based systems (Linux, macOS, etc.)
else()
    find_package(PkgConfig QUIET)
    if(PKG_CONFIG_FOUND)
        pkg_search_module(PC_LIBUSB QUIET libusb-1.0)
    endif()

    find_path(LIBUSB_INCLUDE_DIR
        NAMES libusb.h
        HINTS ${PC_LIBUSB_INCLUDE_DIRS}
        PATH_SUFFIXES libusb-1.0
    )

    find_library(LIBUSB_LIBRARY
        NAMES usb-1.0
        HINTS ${PC_LIBUSB_LIBRARY_DIRS}
    )

    if(LIBUSB_INCLUDE_DIR AND LIBUSB_LIBRARY)
        set(LIBUSB_FOUND TRUE)
        if(NOT TARGET libusb::libusb)
            add_library(libusb::libusb UNKNOWN IMPORTED GLOBAL)
            set_target_properties(libusb::libusb PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${LIBUSB_INCLUDE_DIR}"
                IMPORTED_LOCATION "${LIBUSB_LIBRARY}"
            )
        endif()
    endif()
endif()

# Handle standard REQUIRED/QUIET arguments
find_package_handle_standard_args(libusb REQUIRED_VARS LIBUSB_FOUND)
