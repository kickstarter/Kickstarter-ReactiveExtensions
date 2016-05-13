import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIRefreshControlTests: XCTestCase {
  let control = UIRefreshControl()

  func testRefreshing() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    control.rac.refreshing = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.refreshing))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.control.refreshing))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.control.refreshing))
  }
}
