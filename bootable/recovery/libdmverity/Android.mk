LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := libdmverity.c __common.c pit.c

LOCAL_CFLAGS := -Wall

LOCAL_C_INCLUDES += $(LOCAL_PATH)/..
LOCAL_C_INCLUDES += system/extras/ext4_utils
LOCAL_C_INCLUDES += system/core/fs_mgr/include

LOCAL_MODULE := libdmverity

ifeq (exynos,$(findstring exynos,$(TARGET_SOC)))
LOCAL_CFLAGS += -DEXYNOS_TZ
else
LOCAL_CFLAGS += -DQSEE_TZ
endif

#LOCAL_STATIC_LIBRARIES := libcutils libc
include $(BUILD_STATIC_LIBRARY)


#include $(CLEAR_VARS)
#LOCAL_MODULE := libdevkm_dmverity
#LOCAL_MODULE_TAGS := optional
#LOCAL_PREBUILT_LIBS := libdevkm_dmverity.a
#include $(BUILD_MULTI_PREBUILT)

#include $(CLEAR_VARS)
#LOCAL_SRC_FILES:= tz_cmd.c

#LOCAL_C_INCLUDES += bootable/recovery
#LOCAL_C_INCLUDES += system/extras/ext4_utils
#LOCAL_C_INCLUDES += $(LOCAL_PATH)/inc
#LOCAL_C_INCLUDES += $(TOP)/external/openssl/include
#LOCAL_C_INCLUDES += vendor/samsung/common/external/tima/tima3/tlc_tz_dmverity/public
#LOCAL_C_INCLUDES += vendor/samsung/common/external/tima/tima3/tlc_tz_dmverity/public/msgs
#LOCAL_C_INCLUDES += \
#    vendor/samsung/common/external/tima/tima3/tlc_tima_common \
#    vendor/samsung/common/external/tima/tima3/tz_common/public \
#    vendor/samsung/common/external/tima/tima3/tlc_comm/public

#LOCAL_C_INCLUDES += \
#    vendor/samsung/common/external/tima/tima3/tlc_tima_common \
#    vendor/samsung/common/external/tima/tima3/tz_common/comm \
#    vendor/samsung/common/external/tima/tima3/tlc_comm/public \
#    vendor/samsung/common/external/tima/tima3/tz_common/public \
#    vendor/samsung/common/external/tima/tima3/tlc_tz_dmverity/public \
#    vendor/samsung/common/external/tima/tima3/tlc_tz_dmverity/public/msgs \
#    vendor/samsung/common/external/tima/tima3/tlc_tz_ccm/third_party/openssl/include \
#    vendor/samsung/common/external/tima/tima3/tlc_tz_ccm/third_party/openssl/include/openssl

#LOCAL_MODULE:= dm_verity_tz_cmd

#LOCAL_STATIC_LIBRARIES = libmincrypt libminzip libz
#LOCAL_STATIC_LIBRARIES += libc liblog libext4_utils_static libcrypto_static_dmverity
#LOCAL_SHARED_LIBRARIES = libtlc_tz_dmverity libtlc_comm
#LOCAL_FORCE_STATIC_EXECUTABLE := true
#LOCAL_CFLAGS := -fno-stack-protector

# This binary is in the recovery ramdisk, which is otherwise a copy of root.
# It gets copied there in config/Makefile.  LOCAL_MODULE_TAGS suppresses
# a (redundant) copy of the binary in /system/bin for user builds.
# TODO: Build the ramdisk image in a more principled way.
#LOCAL_MODULE_TAGS := eng

#LOCAL_FORCE_STATIC_EXECUTABLE := true
# LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin
# LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_UNSTRIPPED)
#include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_MODULE := libcrypto_static_dmverity
LOCAL_MODULE_TAGS := optional
LOCAL_PREBUILT_LIBS := libcrypto_static_dmverity.a
include $(BUILD_MULTI_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE    := dm_verity_signature_checker
LOCAL_SRC_FILES := dm_verity_signature_checker.c
LOCAL_C_INCLUDES += $(TOP)/external/openssl/include $(LOCAL_PATH)/inc
ifeq (exynos,$(findstring exynos,$(TARGET_SOC)))
LOCAL_CFLAGS += -DEXYNOS_TZ
else
LOCAL_C_INCLUDES +=  $(TOP)/vendor/qcom/proprietary/securemsm/QSEEComAPI
LOCAL_STATIC_LIBRARIES += libQSEEComAPIStatic
LOCAL_CFLAGS += -DQSEE_TZ
endif
LOCAL_MODULE_TAGS := optional
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT_SBIN)
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_SBIN_UNSTRIPPED)
LOCAL_STATIC_LIBRARIES := libc libcrypto_static_dmverity
include $(BUILD_EXECUTABLE)

#include $(CLEAR_VARS)
#LOCAL_MODULE := libdmverity_test
#LOCAL_FORCE_STATIC_EXECUTABLE := true
#LOCAL_MODULE_TAGS := tests
#
#LOCAL_CFLAGS += -D__USE_DM_VERITY
#
#LOCAL_SRC_FILES := libdmverity_test.c ../roots.cpp ../system.cpp
#
#LOCAL_C_INCLUDES += system/extras/ext4_utils
#LOCAL_C_INCLUDES += $(LOCAL_PATH)/..
#
#LOCAL_STATIC_LIBRARIES := \
#   libdmverity \
#   libfs_mgr \
#   libc \
#   libstdc++ \
#   libext4_utils_static \
#   libmtdutils \
#   libdmverity_hashgen \
#   libmincrypt
#
#include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_MODULE := signature_test
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := tests

LOCAL_CFLAGS += -D__NO_UI_PRINT
LOCAL_CFLAGS += -D__USE_DM_VERITY
LOCAL_CFLAGS += -Wno-narrowing

LOCAL_SRC_FILES := \
    signature_test.c
LOCAL_STATIC_LIBRARIES := libc
#include $(BUILD_EXECUTABLE)



################################################################################
#  libdmverity_rehash is a utility to regenerate the hash of system partition

include $(CLEAR_VARS)
LOCAL_MODULE := dm_verity_rehash
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -D__NO_UI_PRINT
LOCAL_CFLAGS += -D__USE_DM_VERITY

LOCAL_SRC_FILES := dm_verity_rehash.c __common.c  ../roots.cpp  ../system.cpp
LOCAL_C_INCLUDES += system/extras/ext4_utils
LOCAL_C_INCLUDES += system/core/fs_mgr/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/..

LOCAL_STATIC_LIBRARIES := \
    libdmverity  \
    libfs_mgr \
    libc \
    libstdc++ \
    libext4_utils_static \
    libmtdutils \
    libmincrypt   \
    libz

include $(BUILD_EXECUTABLE)

################################################################################


include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := img_dm_verity.c __common.c
LOCAL_MODULE := img_dm_verity
LOCAL_STATIC_LIBRARIES := libext4_utils_host libsparse_host libdmverity_hashgen_host libmincrypt libz
LOCAL_SHARED_LIBRARIES := libcrypto-host
LOCAL_C_INCLUDES += $(LOCAL_PATH)/..
LOCAL_C_INCLUDES += system/extras/ext4_utils
LOCAL_CFLAGS += -D__BUILD_HOST_EXECUTABLE
include $(BUILD_HOST_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := dm_verity_make_ext4fs.py
LOCAL_SRC_FILES := dm_verity_make_ext4fs.py
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_IS_HOST_MODULE := true
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := qseecomfsd
LOCAL_MODULE := qseecomfsd
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT_SBIN)
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)

