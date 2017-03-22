#if os(iOS)
import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIRefreshControlTests: XCTestCase {
  let control = UIRefreshControl()

  func testRefreshing() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    control.rac.refreshing = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isRefreshing))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.control.isRefreshing))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.control.isRefreshing))
  }
}
#endif
