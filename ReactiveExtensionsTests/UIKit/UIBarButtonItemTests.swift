import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIBarButtonItemTests: XCTestCase {
  let barButtonItem = UIBarButtonItem()

  func testEnabled() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    barButtonItem.rac.enabled = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.barButtonItem.isEnabled))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.barButtonItem.isEnabled))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.barButtonItem.isEnabled))
  }
}
