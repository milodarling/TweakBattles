TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = QuickSwipe
QuickSwipe_FILES = QuickSwipe.mm $(wildcard *.m)
QuickSwipe_INSTALL_PATH = /Library/PreferenceBundles
QuickSwipe_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
QuickSwipe_PRIVATE_FRAMEWORKS = Preferences
QuickSwipe_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/QuickSwipe.plist$(ECHO_END)
