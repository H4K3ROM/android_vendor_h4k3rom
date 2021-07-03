# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    SpareParts \
#    LockClock

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    PhaseBeam \
    ThemePicker \
    WallpaperPicker2

# su
PRODUCT_PACKAGES += \
    adb_root

ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif

# Extra Optional packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Email \
    Etar \
    ExactCalculator \
    Exchange2
#    Launcher3Dark


# MusicFX
PRODUCT_PACKAGES += \
    MusicFX

# Phonograph
PRODUCT_PACKAGES += \
    Phonograph

# Jelly
PRODUCT_PACKAGES += \
    Jelly

# OnDeviceAppPrediction
PRODUCT_PACKAGES += \
    AppPredictionService

# OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws

# OmniStyle
PRODUCT_PACKAGES += \
    OmniStyle

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Fonts packages
#PRODUCT_PACKAGES += \
#    invictrix-fonts

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    ntfsfix \
    ntfs-3g \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_H4K3ROM_CHARGER),true)
PRODUCT_PACKAGES += \
    h4k3rom_charger_res_images \
    font_log.png \
    libhealthd.h4k3rom
endif

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

#PRODUCT_PACKAGES += \
#    AndroidDarkThemeOverlay \
#    SettingsDarkThemeOverlay

# Bootanimation include
PRODUCT_PACKAGES += \
    bootanimation.zip

# H4K3ROM OTA
ifneq ($(H4K3ROM_BUILDTYPE),UNOFFICIAL)
PRODUCT_PACKAGES +=  \
   Updater
endif

# H4K3ROM packages
PRODUCT_PACKAGES += \
    FontUbuntuOverlay \
    FontOpenSansOverlay \
    FontComfortaaOverlay \
    FontCaviarDreamsOverlay \
    FontExotwoOverlay \
    FontSnigletOverlay \
    FontSignikaOverlay \
    FontOxaniumOverlay \
    FontInterOverlay \
    TilesWallpaper


-include packages/overlays/H4K3ROM/product_packages.mk
