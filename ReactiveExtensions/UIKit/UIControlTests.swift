import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIControlTests: XCTestCase {

  let control = UIControl()

  func testEnabled() {
    let (signal, observer) = Signal<Bool, Never>.pipe()
    control.rac.enabled = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isEnabled))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.control.isEnabled))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isEnabled))
  }

  func testSelected() {
    let (signal, observer) = Signal<Bool, Never>.pipe()
    control.rac.selected = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isSelected))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.control.isSelected))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isSelected))
  }
}
