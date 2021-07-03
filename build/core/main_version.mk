# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# H4K3ROM System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.h4k3rom.display.version=$(H4K3ROM_VERSION) \
    ro.h4k3rom.buildtype=$(H4K3ROM_BUILDTYPE) \
    ro.h4k3rom.version.update=$(H4K3ROM_BRANCH)-$(VERSION) \
    ro.modversion=$(H4K3ROM_VERSION) \
    ro.h4k3rom.version=$(VERSION)-$(H4K3ROM_BUILDTYPE)

# additions for LOS-recovery
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version=$(VERSION) \
    ro.lineage.version=-$(shell date +%Y%m%d)_$(shell date +%H%M%S)-

# H4K3ROM Stats
ADDITIONAL_BUILD_PROPERTIES += \
    ro.h4k3rom.branch=$(H4K3ROM_BRANCH) \
    ro.romstats.url=https://stats.h4k3rom-rom.com/ \
    ro.romstats.name=H4K3ROM \
    ro.romstats.buildtype=$(H4K3ROM_BUILDTYPE) \
    ro.romstats.version=$(VERSION) \
    ro.romstats.tframe=1 \
    ro.romstats.askfirst=1
