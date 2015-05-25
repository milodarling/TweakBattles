TARGET = :clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = CloudToButt
CloudToButt_FILES = CloudToButt.mm $(wildcard *.m)
CloudToButt_INSTALL_PATH = /Library/PreferenceBundles
CloudToButt_FRAMEWORKS = UIKit MessageUI Social CoreGraphics
CloudToButt_PRIVATE_FRAMEWORKS = Preferences
CloudToButt_LDFLAGS = -lMobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CloudToButt.plist$(ECHO_END)
