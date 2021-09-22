KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

KBUILD_OPTIONS	+= CONFIG_TOUCHSCREEN_SYNA_TCM2=m
# CONFIG_TOUCHSCREEN_SYNA_TCM2_TESTING is not set
# CONFIG_TOUCHSCREEN_SYNA_TCM2_ROMBOOT is not set
EXTRA_CFLAGS	+= -DDYNAMIC_DEBUG_MODULE
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_TBN
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_HEATMAP
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_OFFLOAD
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_SYNA_TCM2_REFLASH
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_SYNA_TCM2_SYSFS
EXTRA_CFLAGS	+= -DCONFIG_TOUCHSCREEN_SYNA_TCM2_TESTING
EXTRA_CFLAGS	+= -DUSE_DRM_BRIDGE
EXTRA_CFLAGS	+= -I$(KERNEL_SRC)/../google-modules/display
EXTRA_CFLAGS	+= -I$(KERNEL_SRC)/../google-modules/touch/common
EXTRA_CFLAGS	+= -I$(KERNEL_SRC)/../google-modules/touch/common/include
EXTRA_CFLAGS	+= -I$(KERNEL_SRC)/../google-modules/touch/synaptics
EXTRA_CFLAGS	+= -I$(KERNEL_SRC)/../google-modules/touch/synaptics/tcm
EXTRA_SYMBOLS	+= $(OUT_DIR)/../google-modules/touch/common/Module.symvers

modules modules_install clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(M) \
	$(KBUILD_OPTIONS) \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	KBUILD_EXTRA_SYMBOLS="$(EXTRA_SYMBOLS)" \
	$(@)
