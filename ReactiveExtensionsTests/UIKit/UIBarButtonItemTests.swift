import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIBarButtonItemTests: XCTestCase {
  let barButtonItem = UIBarButtonItem()

  func testEnabled() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    barButtonItem.rac.enabled = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.barButtonItem.enabled))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.barButtonItem.enabled))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.barButtonItem.enabled))
  }
}
