#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include device/cyanogen/msm8916-common/BoardConfigCommon.mk

#Platform
BOARD_USES_ADRENO := true
QCOM_HARDWARE_VARIANT := msm8916
TARGET_USES_QCOM_BSP := true
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_USES_QCOM_MM_AUDIO := true

# Assertions
TARGET_BOARD_INFO_FILE := device/yu/tomato/board-info.txt

# Audio
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
USE_LEGACY_LOCAL_AUDIO_HAL := true
USE_CUSTOM_AUDIO_POLICY := 1
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_NEW_SAMPLE_RATE := true
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/yu/tomato/bluetooth

# Camera
BOARD_CAMERA_SENSORS := imx135_cp8675 imx214_cp8675 ov5648_cp8675
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_DESTROYED_MUTEX_USAGE_WHITELIST := mm-qcamera-daemon
TARGET_NEEDS_LEGACY_CAMERA_HAL1_DYN_NATIVE_HANDLE := true
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
	/system/bin/mediaserver=23 \
	/system/vendor/bin/mm-qcamera-daemon=23

#HALS Varriant
TARGET_QCOM_DISPLAY_VARIANT := caf-msm8916
TARGET_QCOM_AUDIO_VARIANT := caf-msm8916
TARGET_QCOM_MEDIA_VARIANT := caf-msm8916

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 20971520
BOARD_CACHEIMAGE_PARTITION_SIZE := 134217728
BOARD_PERSISTIMAGE_PARTITION_SIZE := 10485760
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13576175616 # 13576192000 - 16384

# Use mke2fs instead of make_ext4fs
TARGET_USES_MKE2FS := true

# GPS
TARGET_NO_RPC := true
USE_DEVICE_SPECIFIC_GPS := true

# Properties
TARGET_SYSTEM_PROP += device/yu/tomato/system.prop

# HIDL
DEVICE_MANIFEST_FILE := device/yu/tomato/manifest.xml
DEVICE_MATRIX_FILE := device/yu/tomato/compatibility_matrix.xml
# Init
TARGET_LIBINIT_MSM8916_DEFINES_FILE := device/yu/tomato/init/init_tomato.cpp

# Kernel
BOARD_DTBTOOL_ARGS := -2
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true
LZMA_RAMDISK_TARGETS := recovery
TARGET_KERNEL_CONFIG := lineageos_tomato_defconfig
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Lights
BOARD_LIGHTS_VARIANT := aw2013
TARGET_PROVIDES_LIBLIGHT := true

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# PowerHAL
TARGET_POWER_SET_FEATURE_LIB := libpower_set_feature_tomato

# Power
TARGET_PROVIDES_POWERHAL := true

#Wifi
TARGET_PROVIDES_WCNSS_QMI := true
TARGET_QCOM_WLAN_VARIANT := wlan-caf

# Radio
DISABLE_RILD_OEM_HOOK := false
TARGET_USE_OLD_MNC_FORMAT := true

# Recovery
TARGET_RECOVERY_DENSITY := xhdpi
TARGET_RECOVERY_FSTAB := device/yu/tomato/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888

# Inherit from proprietary files
include vendor/yu/tomato/BoardConfigVendor.mk

# Dex optimizion
ifeq ($(HOST_OS),linux)
 ifneq ($(TARGET_BUILD_VARIANT),eng)
   WITH_DEXPREOPT := true
   WITH_DEXPREOPT_DEBUG_INFO := false
   USE_DEX2OAT_DEBUG := false
   USE_DEX2OAT_DEBUG := false
   DONT_DEXPREOPT_PREBUILTS := true
   WITH_DEXPREOPT_PIC := true
   WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
 endif
endif

#SystemServer: Bootimg dex
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt
