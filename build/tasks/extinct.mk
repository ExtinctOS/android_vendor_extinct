EXTINCT_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)

EXTINCT_TARGET := ExtinctOS_$(TARGET_DEVICE)-$(EXTINCT_VERSION)-$(EXTINCT_BUILD_DATE)
EXTINCT_OTA_PACKAGE := $(PRODUCT_OUT)/$(EXTINCT_TARGET).zip
EXTINCT_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/$(EXTINCT_TARGET)-fastboot.zip

$(EXTINCT_OTA_PACKAGE): $(BUILT_TARGET_FILES_PACKAGE) $(OTA_FROM_TARGET_FILES)
	$(call build-ota-package-target,$@, --output_metadata_path $(INTERNAL_OTA_METADATA))
ifneq ($(IS_OFFICIAL),false)
	$(hide) ./vendor/EXTINCT/tools/generate_json_build_info.sh $(EXTINCT_OTA_PACKAGE)
endif

$(EXTINCT_FASTBOOT_PACKAGE): $(BUILT_TARGET_FILES_PACKAGE) $(IMG_FROM_TARGET_FILES)
	$(IMG_FROM_TARGET_FILES) \
		--additional IMAGES/VerifiedBootParams.textproto:VerifiedBootParams.textproto \
	    	$(BUILT_TARGET_FILES_PACKAGE) $@

.PHONY: bacon fastboot

bacon: $(EXTINCT_OTA_PACKAGE)
	@echo "Package Complete: $(EXTINCT_OTA_PACKAGE)"

fastboot: $(EXTINCT_FASTBOOT_PACKAGE)
	@echo "Package Complete: $(EXTINCT_FASTBOOT_PACKAGE)"

