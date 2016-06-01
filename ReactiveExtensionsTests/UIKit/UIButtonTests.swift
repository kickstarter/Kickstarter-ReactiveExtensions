import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UIButtonTests: XCTestCase {
  private let button = UIButton()

  func testTitle() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    button.rac.title = signal

    observer.sendNext("Hello")
    eventually(XCTAssertEqual("Hello", self.button.titleForState(.Normal)))

    observer.sendNext("Hello World")
    eventually(XCTAssertEqual("Hello World", self.button.titleForState(.Normal)))

    observer.sendNext("")
    eventually(XCTAssertEqual("", self.button.titleForState(.Normal)))
  }
}
