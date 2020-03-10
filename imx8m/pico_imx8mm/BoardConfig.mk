#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX8MM
BOARD_HAVE_VPU := true
BOARD_VPU_TYPE := hantro
HAVE_FSL_IMX_GPU2D := true
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_IPU := false
HAVE_FSL_IMX_PXP := false
BOARD_KERNEL_BASE := 0x40400000
TARGET_GRALLOC_VERSION := v3
TARGET_HIGH_PERFORMANCE := true
TARGET_USES_HWC2 := true
TARGET_HWCOMPOSER_VERSION := v2.0
TARGET_HAVE_VIV_HWCOMPOSER = true
TARGET_FSL_IMX_2D := GPU2D
USE_OPENGL_RENDERER := true
TARGET_CPU_SMP := true
TARGET_HAVE_VULKAN := true
ENABLE_CFI=false

#
# Product-specific compile-time definitions.
#

IMX_DEVICE_PATH := device/fsl/imx8m/pico_imx8mm
ADDITION_DRIVERS_PATH := vendor/nxp-opensource/out-of-tree_drivers

include $(IMX_DEVICE_PATH)/build_id.mk
include device/fsl/imx8m/BoardConfigCommon.mk
ifeq ($(PREBUILT_FSL_IMX_CODEC),true)
-include $(FSL_CODEC_PATH)/fsl-codec/fsl-codec.mk
endif

BUILD_TARGET_FS ?= ext4
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_RECOVERY_FSTAB = $(IMX_DEVICE_PATH)/fstab.freescale

# Support gpt
BOARD_BPT_INPUT_FILES += device/fsl/common/partition/device-partitions-13GB-ab.bpt
ADDITION_BPT_PARTITION = partition-table-7GB:device/fsl/common/partition/device-partitions-7GB-ab.bpt \
                         partition-table-28GB:device/fsl/common/partition/device-partitions-28GB-ab.bpt \
                         partition-table-13GB:device/fsl/common/partition/device-partitions-13GB-ab.bpt


# Vendor Interface manifest and compatibility
DEVICE_MANIFEST_FILE := $(IMX_DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(IMX_DEVICE_PATH)/compatibility_matrix.xml

TARGET_BOOTLOADER_BOARD_NAME := PCIO-IMX8MM

PRODUCT_MODEL := PICO_IMX8MM

TARGET_BOOTLOADER_POSTFIX := bin

USE_OPENGL_RENDERER := true
TARGET_CPU_SMP := true

BOARD_WLAN_DEVICE_UNITE      := UNITE
WPA_SUPPLICANT_VERSION       := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

# In UNITE mode,Use default macro for bcmdhd and use unite macro for qcom
ifeq ($(BOARD_WLAN_DEVICE_UNITE), UNITE)
BOARD_WLAN_DEVICE            := bcmdhd
BOARD_HOSTAPD_PRIVATE_LIB_QCA           := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCA    := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_PRIVATE_LIB_BCM           := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_BCM    := lib_driver_cmd_bcmdhd
endif

# QCA wifi support dual interface
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

# QCA qcacld wifi driver module
BOARD_VENDOR_KERNEL_MODULES += \
    $(KERNEL_OUT)/drivers/net/wireless/qcacld-2.0/wlan.ko

BOARD_USE_SENSOR_FUSION := true

# for recovery service
TARGET_SELECT_KEY := 28
# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# BT
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(IMX_DEVICE_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAS_QCA_BT_ROME := true
BOARD_HAVE_BLUETOOTH_BLUEZ := false
QCOM_BT_USE_SIBS := true
ifeq ($(QCOM_BT_USE_SIBS), true)
WCNSS_FILTER_USES_SIBS := false
endif

UBOOT_POST_PROCESS := true

# camera hal v3
IMX_CAMERA_HAL_V3 := true

BOARD_HAVE_USB_CAMERA := true

USE_ION_ALLOCATOR := true
USE_GPU_ALLOCATOR := false

BOARD_AVB_ENABLE := true
ifeq ($(PRODUCT_IMX_TRUSTY),true)
BOARD_AVB_ALGORITHM := SHA256_RSA4096
# The testkey_rsa4096.pem is copied from external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_KEY_PATH := device/fsl/common/security/testkey_rsa4096.pem
endif
TARGET_USES_MKE2FS := true

# define frame buffer count
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

ifeq ($(DRAM_SIZE_1G),true)
CMASIZE=400M
else
CMASIZE=736M
endif

KERNEL_NAME := Image
BOARD_KERNEL_CMDLINE := init=/init androidboot.hwrotation=90 androidboot.console=ttymxc1 androidboot.hardware=freescale cma=$(CMASIZE) androidboot.primary_display=imx-drm firmware_class.path=/vendor/firmware transparent_hugepage=never

# Default wificountrycode
BOARD_KERNEL_CMDLINE += androidboot.wificountrycode=TW

# Defaultly pico_imx8mm use QCA 1PJ wifi module, if use BCM 1MW module, set androidboot.wifivendor=bcm
BOARD_KERNEL_CMDLINE += androidboot.wifivendor=qca

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_PREBUILT_DTBOIMAGE := out/target/product/pico_imx8mm/dtbo-imx8mm.img

TARGET_BOOTLOADER_CONFIG := pico-imx8mm_android_defconfig
TARGET_KERNEL_DEFCONFIG := tn_imx8_android_defconfig
TARGET_KERNEL_ADDITION_DEFCONF := android_addition_defconfig

ifeq ($(AUDIOHAT_ACTIVE),true)
TARGET_BOARD_DTS_CONFIG := imx8mm:imx8mm-pico-pi-ili9881c-voicehat.dtb
ifneq (,$(wildcard $(ADDITION_DRIVERS_PATH)/tfa98xx/snd-soc-tfa98xx.ko))
  BOARD_VENDOR_KERNEL_MODULES += \
  $(ADDITION_DRIVERS_PATH)/tfa98xx/snd-soc-tfa98xx.ko
endif
else
TARGET_BOARD_DTS_CONFIG := imx8mm:imx8mm-pico-pi-ili9881c.dtb
endif

BOARD_SEPOLICY_DIRS := \
       device/fsl/imx8m/sepolicy \
       $(IMX_DEVICE_PATH)/sepolicy

ifeq ($(PRODUCT_IMX_DRM),true)
BOARD_SEPOLICY_DIRS += \
       $(IMX_DEVICE_PATH)/sepolicy_drm
endif

TARGET_BOARD_KERNEL_HEADERS := device/fsl/common/kernel-headers

ifeq ($(NFC_ACTIVE),true)
ifneq ($(AUDIOHAT_ACTIVE),true)
# adding NFC to the build
-include vendor/nxp/nfc/BoardConfigNfc.mk
TARGET_BOARD_DTS_CONFIG := imx8mm:imx8mm-pico-pi-ili9881c-nfc.dtb
endif
endif
