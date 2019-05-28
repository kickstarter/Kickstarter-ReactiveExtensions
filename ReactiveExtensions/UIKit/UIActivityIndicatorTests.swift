import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIActivityIndicatorTests: XCTestCase {
  let indicator = UIActivityIndicatorView()

  func testAnimating() {
    let (signal, observer) = Signal<Bool, Never>.pipe()
    indicator.rac.animating = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.indicator.isAnimating))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.indicator.isAnimating))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.indicator.isAnimating))
  }
}
