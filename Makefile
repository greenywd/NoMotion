ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = NoMotion
NoMotion_FILES = Tweak.xm
NoMotion_FRAMEWORKS = UIKit

xxx_CFLAGS=-fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nomotionprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
