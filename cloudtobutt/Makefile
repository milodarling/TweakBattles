TARGET = iphone:clang:latest:latest
ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = CloudToButt
CloudToButt_FILES = CloudToButt.xm
CloudToButt_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-stage::
	$(ECHO_NOTHING)find $(FW_STAGING_DIR) -iname '*.png' -exec pincrush-osx -i {} \;$(ECHO_END)

after-install::
	install.exec "killall -9 backboardd"
