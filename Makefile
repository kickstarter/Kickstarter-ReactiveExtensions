XCODEBUILD := xcodebuild
IOS_VERSION ?= 16.2
TVOS_VERSION ?= 16.1
IPHONE_NAME ?= iPhone 14 Pro Max
APPLETV_NAME ?= Apple TV 4K (at 1080p) (2nd generation)

test-ios: 
	$(XCODEBUILD) test '-scheme ReactiveExtensions-iOS -destination platform=iOS Simulator,name=$(IPHONE_NAME),OS=$(IOS_VERSION)'

test-tvos: 
	$(XCODEBUILD) test '-scheme ReactiveExtensions-tvOS -destination platform=tvOS Simulator,name=$(APPLETV_NAME),OS=$(TVOS_VERSION)'
