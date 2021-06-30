define build-changelog
    sh vendor/lineage/tools/changelog.sh
endef

TARGET_GENERATED_CHANGELOG := $(TARGET_OUT_INTERMEDIATES)/CHANGELOG/Changelog.html
$(TARGET_GENERATED_CHANGELOG):
	@echo "Building Changelog"
	$(build-changelog)

include $(CLEAR_VARS)
LOCAL_MODULE := Changelog.html
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/etc

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_GENERATED_CHANGELOG)
	@mkdir -p $(dir $@)
	@cp $(TARGET_GENERATED_CHANGELOG) $@
