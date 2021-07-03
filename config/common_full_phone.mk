# Inherit full common H4K3ROM stuff
$(call inherit-product, vendor/h4k3rom/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include H4K3ROM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/h4k3rom/overlay/dictionaries

$(call inherit-product, vendor/h4k3rom/config/telephony.mk)
