#if os(iOS)
import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UISwitchTests: XCTestCase {
  let uiSwitch = UISwitch()

  func testOn() {
    let (signal, observer) = Signal<Bool, Never>.pipe()
    uiSwitch.rac.on = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.uiSwitch.isOn))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.uiSwitch.isOn))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.uiSwitch.isOn))
  }
}
#endif
