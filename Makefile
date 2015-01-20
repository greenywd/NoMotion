ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = Packages
GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = NoMotion
NoMotion_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += nomotion
include $(THEOS_MAKE_PATH)/aggregate.mk
