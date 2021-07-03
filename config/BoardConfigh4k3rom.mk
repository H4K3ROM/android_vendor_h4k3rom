# Charger
ifeq ($(WITH_H4K3ROM_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.h4k3rom
endif

# things to be set on AB devices
ifeq ($(TARGET_IS_AB_DEVICE),true)
    AB_OTA_UPDATER := true
endif

include vendor/h4k3rom/config/BoardConfigKernel.mk
ifeq ($(TARGET_KERNEL_CLANG_VERSION),latest)
include prebuilts/clang/host/linux-x86_custom/clang_custom.mk
endif
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/h4k3rom/config/BoardConfigQcom.mk
endif

include vendor/h4k3rom/config/BoardConfigSoong.mk
