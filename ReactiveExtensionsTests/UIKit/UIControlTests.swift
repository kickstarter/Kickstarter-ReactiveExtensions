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
    XCTAssertTrue(control.enabled)

    observer.sendNext(false)
    XCTAssertFalse(control.enabled)

    observer.sendNext(true)
    XCTAssertTrue(control.enabled)
  }
}
