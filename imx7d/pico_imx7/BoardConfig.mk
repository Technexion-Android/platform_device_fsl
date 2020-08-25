#
# Product-specific compile-time definitions.
#

IMX_DEVICE_PATH := device/fsl/imx7d/pico_imx7
ADDITION_DRIVERS_PATH := vendor/nxp-opensource/out-of-tree_drivers

include $(IMX_DEVICE_PATH)/build_id.mk
include device/fsl/imx7d/BoardConfigCommon.mk
ifeq ($(PREBUILT_FSL_IMX_CODEC),true)
-include $(FSL_CODEC_PATH)/fsl-codec/fsl-codec.mk
endif

TARGET_USES_64_BIT_BINDER := true

BUILD_TARGET_FS ?= ext4
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_RECOVERY_FSTAB = $(IMX_DEVICE_PATH)/fstab.freescale

# Vendor Interface manifest and compatibility
DEVICE_MANIFEST_FILE := $(IMX_DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(IMX_DEVICE_PATH)/compatibility_matrix.xml

TARGET_BOOTLOADER_BOARD_NAME := PICO-IMX7
PRODUCT_MODEL := PICO-IMX7

TARGET_BOOTLOADER_POSTFIX := imx
TARGET_DTB_POSTFIX := -dtb

# UNITE is a virtual device.
BOARD_WLAN_DEVICE            := qcwcn
WPA_SUPPLICANT_VERSION       := VER_0_8_X

BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB               := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB        := lib_driver_cmd_qcwcn

WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

WIFI_DRIVER_FW_PATH_PARAM      := "/sys/module/brcmfmac/parameters/alternative_fw_path"

BOARD_VENDOR_KERNEL_MODULES += \
                            $(KERNEL_OUT)/drivers/net/wireless/qcacld-2.0/wlan.ko

ifeq ($(AUDIOHAT_ACTIVE),true)
ifneq (,$(wildcard $(ADDITION_DRIVERS_PATH)/tfa98xx/snd-soc-tfa98xx.ko))
BOARD_VENDOR_KERNEL_MODULES += \
   $(ADDITION_DRIVERS_PATH)/tfa98xx/snd-soc-tfa98xx.ko
endif
endif
#for accelerator sensor, need to define sensor type here
BOARD_USE_SENSOR_FUSION := true
#SENSOR_MMA8451 := true
BOARD_USE_SENSOR_PEDOMETER := false
BOARD_USE_LEGACY_SENSOR := true

# for recovery service
TARGET_SELECT_KEY := 28
# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Qcom 1CQ(QCA6174) BT
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(IMX_DEVICE_PATH)/bluetooth

BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAS_QCA_BT_ROME := true
BOARD_HAVE_BLUETOOTH_BLUEZ := false
QCOM_BT_USE_SIBS := true
ifeq ($(QCOM_BT_USE_SIBS), true)
WCNSS_FILTER_USES_SIBS := false
endif

USE_ION_ALLOCATOR := true
USE_GPU_ALLOCATOR := false

# define frame buffer count
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

KERNEL_NAME := zImage
BOARD_KERNEL_CMDLINE := console=ttymxc4,115200 init=/init video=mxcfb0:dev=lcd,800x480@60,if=RGB24,bpp=24 video=mxcfb1:off androidboot.console=ttymxc4 consoleblank=0 androidboot.hardware=freescale cma=320M loop.max_part=7 quiet
# u-boot target for imx7d_sabresd with HDMI or LCD display
TARGET_BOOTLOADER_CONFIG := pico-imx7d_android_spl_defconfig
ifeq ($(EXPORT_BASEBOARD_NAME),PI)

ifeq ($(AUDIOHAT_ACTIVE),true)
  TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-pico-qca_pi-voicehat.dtb
else
  TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-pico-qca_pi.dtb
endif

else ifeq ($(EXPORT_BASEBOARD_NAME),DWARF)
  TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-pico-qca_dwarf.dtb
else ifeq ($(EXPORT_BASEBOARD_NAME),NYMPH)
  TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-pico-qca_nymph.dtb
	BOARD_KERNEL_CMDLINE := console=ttymxc4,115200 init=/init video=mxcfb0:dev=lcd,1024x768@60,if=RGB24,bpp=24 video=mxcfb1:off androidboot.console=ttymxc4 consoleblank=0 androidboot.hardware=freescale cma=320M loop.max_part=7
else ifeq ($(EXPORT_BASEBOARD_NAME),HOBBIT)
  TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-pico-qca_hobbit.dtb
endif
TARGET_KERNEL_DEFCONFIG := tn_android_defconfig
TARGET_KERNEL_ADDITION_DEFCONF ?= android_addition_defconfig

BOARD_PREBUILT_DTBOIMAGE := out/target/product/pico_imx7/dtbo-imx7d.img


BOARD_SEPOLICY_DIRS := \
       device/fsl/imx7d/sepolicy \
       $(IMX_DEVICE_PATH)/sepolicy

# Support gpt
BOARD_BPT_INPUT_FILES += device/fsl/common/partition/device-partitions-7GB.bpt
ADDITION_BPT_PARTITION = partition-table-14GB:device/fsl/common/partition/device-partitions-14GB.bpt \
                         partition-table-28GB:device/fsl/common/partition/device-partitions-28GB.bpt \
                         partition-table-3GB:device/fsl/common/partition/device-partitions-3GB.bpt \
                         partition-table-7GB:device/fsl/common/partition/device-partitions-7GB.bpt

TARGET_BOARD_KERNEL_HEADERS := device/fsl/common/kernel-headers

#Enable AVB
BOARD_AVB_ENABLE := true
TARGET_USES_MKE2FS := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_USES_FULL_RECOVERY_IMAGE := true
