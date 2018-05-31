# Use the non-open-source part, if present
-include vendor/mediateksample/fd3902/BoardConfigVendor.mk

# Use the 6739 common part
include device/mediatek/mt6739/BoardConfig.mk

#Config partition size
-include $(MTK_PTGEN_OUT)/partition_size.mk
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096
# Vanzo:hanshengpeng on: Thu, 21 Dec 2017 23:18:10 +0800
# modify system img size for add gms packages
#BOARD_MTK_SYSTEM_SIZE_KB := 1048576
BOARD_MTK_SYSTEM_SIZE_KB := 1258291
# End of Vanzo:hanshengpeng
BOARD_MTK_CACHE_SIZE_KB := 114688
BOARD_MTK_VENDOR_SIZE_KB := 460800


MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$(strip $($(t)))\"))

MTK_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)
# Vanzo:yucheng on: Tue, 21 Nov 2017 14:19:02 +0800
# added for aosp management to import custom config
ifneq ($(strip $(project_name)),)
VANZO_INTERNAL_CDEFS := $(foreach t,$(VANZO_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
VANZO_INTERNAL_CDEFS += $(foreach t,$(VANZO_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
VANZO_INTERNAL_CDEFS += $(foreach t,$(VANZO_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$(strip $($(t)))\"))
MTK_GLOBAL_CFLAGS += $(VANZO_INTERNAL_CDEFS)
endif
# End of Vanzo:yucheng

ifneq ($(MTK_K64_SUPPORT), yes)
BOARD_KERNEL_CMDLINE = bootopt=64S3,32S1,32S1
else
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2
endif

#A-GO
MALLOC_SVELTE := true
