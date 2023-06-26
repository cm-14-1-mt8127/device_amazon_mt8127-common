DEVICE_COMMON := device/amazon/mt8127-common
KERNEL_COMMON := kernel/amazon/mt8127-common
VENDOR_COMMON := vendor/amazon/mt8127-common

# headers
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_COMMON)/include

# inherit from the proprietary version
-include $(VENDOR_COMMON)/BoardConfigVendor.mk

# Platform
TARGET_BOARD_PLATFORM := mt8127
TARGET_BOARD_PLATFORM_GPU := mali-450mp4

# Arch
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true

# Kernel Config
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_CMDLINE += androidboot.hardware=mt8127
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
TARGET_KERNEL_SOURCE := $(KERNEL_COMMON)
BOARD_MKBOOTIMG_ARGS := --cmdline "$(BOARD_KERNEL_CMDLINE)" --base 0x80000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x04000000 --second_offset 0x00f00000 --tags_offset 0x00000100

TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-eabi-
KERNEL_TOOLCHAIN := $(shell pwd)/prebuilts/gcc/linux-x86/arm/$(TARGET_KERNEL_CROSS_COMPILE_PREFIX)4.8/bin

BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true

# Flags
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -DMTK_HARDWARE -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CFLAGS += -DREFRESH_RATE=60
TARGET_GLOBAL_CFLAGS += -DMTK_HARDWARE
TARGET_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
TARGET_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# WIFI
BOARD_WLAN_DEVICE := MediaTek
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM := /dev/wmtWifi
WIFI_DRIVER_FW_PATH_AP := AP
WIFI_DRIVER_FW_PATH_STA := STA
WIFI_DRIVER_FW_PATH_P2P := P2P
WIFI_DRIVER_STATE_CTRL_PARAM := /dev/wmtWifi
WIFI_DRIVER_STATE_ON := 1
WIFI_DRIVER_STATE_OFF := 0

# BT
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_COMMON)/bluetooth

# Graphics
BOARD_EGL_CFG := $(DEVICE_COMMON)/configs/egl.cfg
BOARD_EGL_NEEDS_HANDLE_VALUE := true
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_OVERLAY := true
TARGET_USES_ION := true
TARGET_DISPLAY_USE_RETIRE_FENCE := true
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 1024*1024

TARGET_HAS_LEGACY_CAMERA_HAL1 := true
TARGET_USES_MEDIA_EXTENSIONS := true

# Surfaceflinger optimization for VD surfaces
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3


# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1258291200
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6227082752
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

BLOCK_BASED_OTA := true

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file

# Shims
LINKER_FORCED_SHIM_LIBS := \
    /system/lib/libbinder.so|libshim_libbinder.so \
    /system/lib/liblog.so|libshim_liblog.so \
    /system/lib/libcutils.so|libshim_liblog.so \
    /system/vendor/lib/libwvm.so|libshim_libwvm.so \
    /system/lib/libasp.so|libshim_libbinder.so \
    /system/lib/libcam_utils.so|libshim_libcamera.so \
    /system/lib/libMtkOmxVdec.so|libshim_libcamera.so \
    /system/lib/libMtkOmxVenc.so|libshim_libcamera.so \
    /system/lib/libcam.utils.sensorlistener.so|libshim_libcamera.so \
    /system/lib/libcam_platform.so|libshim_libcamera.so \
    /system/lib/libaal.so|libshim_skia.so \
    /system/lib/libaal.so|libshim_gui.so \
    /system/lib/libaal.so|libshim_libbinder.so

# TWRP
ifneq (,$(strip $(wildcard bootable/recovery-twrp/twrp.cpp)))
RECOVERY_VARIANT := twrp
endif
DEVICE_RESOLUTION := 600x1024
TW_EXCLUDE_MTP := false
RECOVERY_SDCARD_ON_DATA := true
TW_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_FSTAB_VERSION := 2
TW_THEME := landscape_mdpi
#TWRP_EVENT_LOGGING := true
RECOVERY_TOUCHSCREEN_SWAP_XY := true
#RECOVERY_GRAPHICS_USE_LINELENGTH := true
#RECOVERY_TOUCHSCREEN_FLIP_Y := true 
RECOVERY_TOUCHSCREEN_FLIP_X := true
BOARD_HAS_FLIPPED_SCREEN := true

# SELinux
BOARD_SECCOMP_POLICY += $(DEVICE_COMMON)/seccomp
BOARD_SEPOLICY_DIRS += $(DEVICE_COMMON)/sepolicy

# Disable API check
WITHOUT_CHECK_API := true
