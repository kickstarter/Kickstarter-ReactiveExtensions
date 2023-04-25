test-ios: 
	xcodebuild test -scheme ReactiveExtensions-iOS -destination platform='iOS Simulator',name='iPhone 14 Pro Max',OS=16.2

test-tvos: 
	xcodebuild test -scheme ReactiveExtensions-tvOS -destination platform='tvOS Simulator',name='Apple TV 4K (3rd generation) (at 1080p)',OS=16.1
