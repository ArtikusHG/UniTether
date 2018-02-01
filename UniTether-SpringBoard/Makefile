THEOS_DEVICE_IP = 192.168.1.132
ARCHS = armv7 armv7s arm64
include /Users/artikus/theos/makefiles/common.mk

TWEAK_NAME = UniTether
UniTether_FILES = Tweak.xm
UniTether_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
