include theos/makefiles/common.mk

BUNDLE_NAME = nomotionprefs
nomotionprefs_FILES = nomotionprefs.mm
nomotionprefs_INSTALL_PATH = /Library/PreferenceBundles
nomotionprefs_FRAMEWORKS = UIKit
nomotionprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/nomotionprefs.plist$(ECHO_END)
