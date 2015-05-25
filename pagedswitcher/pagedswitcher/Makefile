TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = PagedSwitcher
PagedSwitcher_FILES = PagedSwitcher.mm $(wildcard *.m)
PagedSwitcher_INSTALL_PATH = /Library/PreferenceBundles
PagedSwitcher_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
PagedSwitcher_PRIVATE_FRAMEWORKS = Preferences
PagedSwitcher_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PagedSwitcher.plist$(ECHO_END)
