TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = SafariWallSetter
SafariWallSetter_FILES = SafariWallSetter.mm $(wildcard *.m)
SafariWallSetter_INSTALL_PATH = /Library/PreferenceBundles
SafariWallSetter_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
SafariWallSetter_PRIVATE_FRAMEWORKS = Preferences
SafariWallSetter_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SafariWallSetter.plist$(ECHO_END)
