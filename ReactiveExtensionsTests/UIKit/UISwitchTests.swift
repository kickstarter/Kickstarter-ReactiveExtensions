#if os(iOS)
import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UISwitchTests: XCTestCase {
  let uiSwitch = UISwitch()

  func testOn() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    uiSwitch.rac.on = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.uiSwitch.on))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.uiSwitch.on))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.uiSwitch.on))
  }
}
#endif
