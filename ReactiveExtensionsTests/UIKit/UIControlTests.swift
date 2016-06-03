import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIControlTests: XCTestCase {

  let control = UIControl()

  func testEnabled() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    control.rac.enabled = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.enabled))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.control.enabled))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.enabled))
  }

  func testSelected() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    control.rac.selected = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.selected))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.control.selected))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.selected))
  }
}
