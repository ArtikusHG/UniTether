export TARGET = iphone:8.1:8.1
export ARCHS = armv7 armv7s arm64
export THEOS_DEVICE_IP = 192.168.1.132
include /Users/artikus/theos/makefiles/common.mk

APPLICATION_NAME = cold
cold_CODESIGN_FLAGS = -Sentitlements.plist
cold_FILES = coldmain.m coldApplicaion.xm RootViewController.mm
cold_FRAMEWORKS = UIKit CoreGraphics
cold_PRIVATE_FRAMEWORKS = GraphicsServices BackBoardServices
cold_INSTALL_PATH = /System/Library/CoreServices/
include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "chown root:wheel /Library/LaunchDaemons/com.artikus.cold.plist"
	install.exec "launchctl unload /Library/LaunchDaemons/com.artikus.cold.plist"
	install.exec "launchctl load /Library/LaunchDaemons/com.artikus.cold.plist"
