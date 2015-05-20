TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = SpotCleaner
SpotCleaner_FILES = SpotCleaner.mm $(wildcard *.m)
SpotCleaner_INSTALL_PATH = /Library/PreferenceBundles
SpotCleaner_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
SpotCleaner_PRIVATE_FRAMEWORKS = Preferences
SpotCleaner_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SpotCleaner.plist$(ECHO_END)
