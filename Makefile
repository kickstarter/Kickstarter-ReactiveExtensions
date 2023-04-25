test-ios: 
	xcodebuild test -scheme ReactiveExtensions-iOS -destination platform=iOS Simulator,name='iPhone 14 Pro Max',OS=16.2

test-tvos: 
	xcodebuild test -scheme ReactiveExtensions-tvOS -destination platform=tvOS Simulator,name='Apple TV 4K (at 1080p) (2nd generation)',OS=16.1
