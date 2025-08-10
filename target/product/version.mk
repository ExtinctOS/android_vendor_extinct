EXTINCT_VERSION := 1.0
EXTINCT_BUILD_DATE := $(shell date -u +%s)

PRODUCT_SYSTEM_PROPERTIES += \
    ro.extinct.version=$(EXTINCT_VERSION) \
    ro.EXTINCT.date.utc=$(shell date -d @$(EXTINCT_BUILD_DATE) +%s)
