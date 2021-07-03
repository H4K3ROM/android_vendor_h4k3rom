# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Include H4K3ROM version
include vendor/h4k3rom/config/h4k3rom_version.mk

# Include H4K3ROM packages
include vendor/h4k3rom/config/h4k3rom_packages.mk

# Include H4K3ROM version
include vendor/h4k3rom/config/h4k3rom_props.mk

# AOSP recovery flashing
ifeq ($(TARGET_USES_AOSP_RECOVERY),true)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.recovery_update=true
endif

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true

# Include AOSP audio files
include vendor/h4k3rom/config/aosp_audio.mk

# Google sounds
include vendor/h4k3rom/google/GoogleAudio.mk

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/h4k3rom/overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/h4k3rom/overlay/common

# TWRP
ifeq ($(BUILD_TWRP),true)
RECOVERY_TYPE := twrp
else
RECOVERY_TYPE := aosp
endif

# Copy all H4K3ROM specific init rc files
$(foreach f,$(wildcard vendor/h4k3rom/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Clean cache script
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/bin/clean_cache.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/clean_cache.sh

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/h4k3rom/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/h4k3rom/prebuilt/common/bin/50-h4k3rom.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-h4k3rom.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/h4k3rom/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/h4k3rom/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# system mount
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/bin/system-mount.sh:install/bin/system-mount.sh

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml

# H4K3ROM permissions
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/config/permissions/privapp-permissions-h4k3rom-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-h4k3rom.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-h4k3rom-system-ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-h4k3rom.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-h4k3rom-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-h4k3rom.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/config/permissions/lineage-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/h4k3rom/prebuilt/common/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    vendor/h4k3rom/prebuilt/common/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Google extra permissions and features
PRODUCT_COPY_FILES += \
#    vendor/h4k3rom/config/permissions/android.software.live_wallpaper.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.live_wallpaper.xml \
    vendor/h4k3rom/config/permissions/com.google.android.dialer.support.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.google.android.dialer.support.xml \
    vendor/h4k3rom/config/permissions/com.google.android.feature.ANDROID_ONE_EXPERIENCE.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.google.android.feature.ANDROID_ONE_EXPERIENCE.xml \
#    vendor/h4k3rom/config/permissions/privapp-permissions-platform.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-platform.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-google-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google-product.xml \
    vendor/h4k3rom/config/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-hotword.xml \
    vendor/h4k3rom/config/permissions/google_build.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/google_build.xml \
    vendor/h4k3rom/config/permissions/google-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/google-hiddenapi-package-whitelist.xml \
#    vendor/h4k3rom/config/permissions/hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hiddenapi-package-whitelist.xml \
    vendor/h4k3rom/config/permissions/nexus.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/nexus.xml \
    vendor/h4k3rom/config/permissions/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_2016_exclusive.xml \
    vendor/h4k3rom/config/permissions/pixel_2017_exclusive.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_2017_exclusive.xml \
    vendor/h4k3rom/config/permissions/pixel_2018_exclusive.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_2018_exclusive.xml \
    vendor/h4k3rom/config/permissions/pixel_2019_midyear_exclusive.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_2019_midyear_exclusive.xml \
    vendor/h4k3rom/config/permissions/pixel_experience_2017.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_experience_2017.xml \
    vendor/h4k3rom/config/permissions/pixel_experience_2018.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_experience_2018.xml \
    vendor/h4k3rom/config/permissions/pixel_experience_2019_midyear.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_experience_2019_midyear.xml

# Google extra libraries (sketch/swipe)
PRODUCT_COPY_FILES += \
    vendor/h4k3rom/prebuilt/common/lib/libsketchology_native.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libsketchology_native.so \
    vendor/h4k3rom/prebuilt/common/lib64/libsketchology_native.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libsketchology_native.so
