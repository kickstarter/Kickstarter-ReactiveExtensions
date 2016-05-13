import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class NSLayoutConstraintTests: XCTestCase {
  let constraint = NSLayoutConstraint()

  func testConstant() {
    let (signal, observer) = Signal<CGFloat, NoError>.pipe()
    constraint.rac.constant = signal

    observer.sendNext(1.0)
    eventually(XCTAssertEqual(1.0, self.constraint.constant))

    observer.sendNext(0.0)
    eventually(XCTAssertEqual(0.0, self.constraint.constant))

    observer.sendNext(-1.0)
    eventually(XCTAssertEqual(-1.0, self.constraint.constant))
  }
}
