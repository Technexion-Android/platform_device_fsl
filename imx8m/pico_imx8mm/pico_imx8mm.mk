# This is a FSL Android Reference Design platform based on i.MX8QP ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

IMX_DEVICE_PATH := device/fsl/imx8m/pico_imx8mm

-include device/fsl/common/imx_path/ImxPathConfig.mk
$(call inherit-product, device/fsl/imx8m/ProductConfigCommon.mk)

ifneq ($(wildcard $(IMX_DEVICE_PATH)/fstab.freescale),)
$(shell touch $(IMX_DEVICE_PATH)/fstab.freescale)
endif

# Overrides
PRODUCT_NAME := pico_imx8mm
PRODUCT_DEVICE := pico_imx8mm

PRODUCT_FULL_TREBLE_OVERRIDE := true

#Enable this to include trusty support
#PRODUCT_IMX_TRUSTY := true

# Include keystore attestation keys and certificates.
ifeq ($(PRODUCT_IMX_TRUSTY),true)
-include $(IMX_SECURITY_PATH)/attestation/imx_attestation.mk
endif

# Copy device related config and binary to board
PRODUCT_COPY_FILES += \
    $(FSL_PROPRIETARY_PATH)/fsl-proprietary/gpu-viv/lib/egl/egl.cfg:$(TARGET_COPY_OUT_VENDOR)/lib/egl/egl.cfg \
    $(FSL_PROPRIETARY_PATH)/fsl-proprietary/gpu-viv/lib64/egl/egl.cfg:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/egl.cfg \
    $(FSL_PROPRIETARY_PATH)/fsl-proprietary/mcu-sdk/imx8mm/imx8mm_m4_demo.img:imx8mm_m4_demo.img \
    $(IMX_DEVICE_PATH)/app_whitelist.xml:system/etc/sysconfig/app_whitelist.xml \
    $(IMX_DEVICE_PATH)/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(IMX_DEVICE_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(IMX_DEVICE_PATH)/usb_audio_policy_configuration-direct-output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration-direct-output.xml \
    $(IMX_DEVICE_PATH)/fstab.freescale:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.freescale \
    $(IMX_DEVICE_PATH)/init.freescale.emmc.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.freescale.emmc.rc \
    $(IMX_DEVICE_PATH)/init.freescale.emmc.rc:root/init.recovery.freescale.emmc.rc \
    $(IMX_DEVICE_PATH)/init.freescale.sd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.freescale.sd.rc \
    $(IMX_DEVICE_PATH)/init.freescale.sd.rc:root/init.recovery.freescale.sd.rc \
    $(IMX_DEVICE_PATH)/init.imx8mm.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.freescale.imx8mm.rc \
    $(IMX_DEVICE_PATH)/early.init.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/early.init.cfg \
    $(IMX_DEVICE_PATH)/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.freescale.rc \
    $(IMX_DEVICE_PATH)/init.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.freescale.usb.rc \
    $(IMX_DEVICE_PATH)/required_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/required_hardware.xml \
    $(IMX_DEVICE_PATH)/privapp-permissions-imx.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-imx.xml \
    $(IMX_DEVICE_PATH)/ueventd.freescale.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(LINUX_FIRMWARE_IMX_PATH)/linux-firmware-imx/firmware/sdma/sdma-imx7d.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/imx/sdma/sdma-imx7d.bin \
    device/fsl/common/init/init.insmod.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.insmod.sh \
    device/fsl/common/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    device/fsl/common/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    device/fsl/common/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/qca_wpa_supplicant_overlay.conf \
    device/fsl/common/wifi/bcm_wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/bcm_wpa_supplicant_overlay.conf

ifeq ($(PRODUCT_IMX_TRUSTY),true)
PRODUCT_COPY_FILES += \
    device/fsl/common/security/rpmb_key_test.bin:rpmb_key_test.bin \
    device/fsl/common/security/testkey_public_rsa4096.bin:testkey_public_rsa4096.bin
endif

# ONLY devices that meet the CDD's requirements may declare these features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml \
    frameworks/native/data/etc/android.software.device_admin.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_admin.xml \
    frameworks/native/data/etc/android.software.managed_users.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.managed_users.xml \
    frameworks/native/data/etc/android.software.print.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.print.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.voice_recognizers.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.voice_recognizers.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.activities_on_secondary_displays.xml \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.picture_in_picture.xml

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    $(IMX_DEVICE_PATH)/seccomp/mediacodec-seccomp.policy:vendor/etc/seccomp_policy/mediacodec.policy \
    $(IMX_DEVICE_PATH)/seccomp/mediaextractor-seccomp.policy:vendor/etc/seccomp_policy/mediaextractor.policy

# fastboot_imx_flashall scripts, fsl-sdcard-partition script uuu_imx_android_flash scripts
PRODUCT_COPY_FILES += \
    device/fsl/common/tools/fastboot_imx_flashall.bat:fastboot_imx_flashall.bat \
    device/fsl/common/tools/fastboot_imx_flashall.sh:fastboot_imx_flashall.sh \
    device/fsl/common/tools/fsl-sdcard-partition.sh:fsl-sdcard-partition.sh \
    device/fsl/common/tools/uuu_imx_android_flash.bat:uuu_imx_android_flash.bat \
    device/fsl/common/tools/uuu_imx_android_flash.sh:uuu_imx_android_flash.sh


USE_XML_AUDIO_POLICY_CONF := 1

DEVICE_PACKAGE_OVERLAYS := $(IMX_DEVICE_PATH)/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi xhdpi

# HWC2 HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service

# Gralloc HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

PRODUCT_PACKAGES += \
    libEGL_VIVANTE \
    libGLESv1_CM_VIVANTE \
    libGLESv2_VIVANTE \
    gralloc_viv.imx8 \
    libGAL \
    libGLSLC \
    libVSC \
    libg2d \
    libgpuhelper \
    gatekeeper.imx8

PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-impl:32 \
    android.hardware.audio@2.0-service \
    android.hardware.audio.effect@4.0-impl:32 \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.configstore@1.1-service \
    configstore@1.1.policy

# Usb HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.1-service.imx

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

# Qcom 1PJ Bluetooth Firmware
PRODUCT_COPY_FILES += \
    vendor/nxp/qca-wifi-bt/qca_proprietary/Android_HAL/wcnss_filter_8mm:vendor/bin/wcnss_filter

# QCA9377 Bluetooth Firmware
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/bluetooth/rampatch_tlv_3.2.tlv))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/bluetooth/rampatch_tlv_3.2.tlv:$(TARGET_COPY_OUT_VENDOR)/firmware/qca/rampatch_tlv_tf_1.0.tlv \
device/fsl/imx8m/pico_imx8mm/bluetooth/rampatch_tlv_3.2.tlv:$(TARGET_COPY_OUT_VENDOR)/firmware/qca/tfbtfw11.tlv
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/bluetooth/nvm_tlv_3.2.bin))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/bluetooth/nvm_tlv_3.2.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/qca/nvm_tlv_tf_1.0.bin \
device/fsl/imx8m/pico_imx8mm/bluetooth/nvm_tlv_3.2.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/qca/tfbtnv11.bin
endif

# WiFi HAL
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    wifilogd \
    wificond

# Qcom WiFi Firmware
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/wlan/cfg.dat))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/wlan/cfg.dat:vendor/firmware/wlan/cfg.dat
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/wlan/qcom_cfg.ini))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/wlan/qcom_cfg.ini:vendor/firmware/wlan/qcom_cfg.ini
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/bdwlan30.bin))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/bdwlan30.bin:vendor/firmware/bdwlan30.bin
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/otp30.bin))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/otp30.bin:vendor/firmware/otp30.bin
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/qwlan30.bin))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/qwlan30.bin:vendor/firmware/qwlan30.bin
endif
ifneq (,$(wildcard device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/utf30.bin))
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/wifi-firmware/QCA9377/utf30.bin:vendor/firmware/utf30.bin
endif

# QCA wifi supplicant for UNITE mode
PRODUCT_PACKAGES += \
    qca_hostapd \
    qca_wpa_supplicant \
    android.hardware.wifi@1.0-service.qca

# QCA bluetooth for UNITE mode
PRODUCT_PACKAGES += \
    libbt-vendor-unite-qca

# bootanimation ui
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/ui/bootanimation.zip:system/media/bootanimation.zip

# audio-hat relative firmware
PRODUCT_COPY_FILES += \
device/fsl/imx8m/pico_imx8mm/firmware/TFA9892N1A_stereo_32FS.cnt:vendor/firmware/tfa98xx.cnt

# Keymaster HAL
ifeq ($(PRODUCT_IMX_TRUSTY),true)
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-service.trusty
endif
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# DRM HAL
TARGET_ENABLE_MEDIADRM_64 := true
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service

# new gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

ifneq ($(BUILD_TARGET_FS),ubifs)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.internel.storage_size=/sys/block/mmcblk2/size \
    ro.frp.pst=/dev/block/by-name/presistdata
endif

# ro.product.first_api_level indicates the first api level the device has commercially launched on.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=28

PRODUCT_PACKAGES += \
    libg1 \
    libhantro \
    libcodec \
    libhantro_h1 \
    libcodec_enc \
    DirectAudioPlayer

ifeq ($(DRAM_SIZE_1G),true)
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
endif

# Add oem unlocking option in settings.
PRODUCT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/presistdata
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Add Trusty OS backed gatekeeper and secure storage proxy
ifeq ($(PRODUCT_IMX_TRUSTY),true)
PRODUCT_PACKAGES += \
    gatekeeper.trusty \
    storageproxyd
endif

ifeq ($(NFC_ACTIVE),true)
# adding NFC to the build
$(call inherit-product, vendor/nxp/nfc/device-nfc.mk)
endif
