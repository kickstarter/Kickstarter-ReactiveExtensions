import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UILabelTests: XCTestCase {

  let label = UILabel()

  func testText() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    label.rac.text = signal

    observer.sendNext("The future")
    XCTAssertEqual("The future", label.text)

    observer.sendNext("")
    XCTAssertEqual("", label.text)
  }
}
