import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class NSLayoutConstraintTests: XCTestCase {
  let constraint = NSLayoutConstraint()

  func testConstant() {
    let (signal, observer) = Signal<CGFloat, Never>.pipe()
    constraint.rac.constant = signal

    observer.send(value: 1.0)
    eventually(XCTAssertEqual(1.0, self.constraint.constant))

    observer.send(value: 0.0)
    eventually(XCTAssertEqual(0.0, self.constraint.constant))

    observer.send(value: -1.0)
    eventually(XCTAssertEqual(-1.0, self.constraint.constant))
  }
}
