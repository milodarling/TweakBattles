TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = TayRotator
TayRotator_FILES = TayRotator.mm $(wildcard *.m)
TayRotator_INSTALL_PATH = /Library/PreferenceBundles
TayRotator_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
TayRotator_PRIVATE_FRAMEWORKS = Preferences
TayRotator_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TayRotator.plist$(ECHO_END)
