import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIActivityIndicatorTests: XCTestCase {
  let indicator = UIActivityIndicatorView()

  func testAnimating() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    indicator.rac.animating = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.indicator.isAnimating()))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.indicator.isAnimating()))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.indicator.isAnimating()))
  }
}
