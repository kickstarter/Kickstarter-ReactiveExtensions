import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITextFieldTests: XCTestCase {
  let textField = UITextField()

  func testText() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    textField.rac.text = signal

    observer.sendNext("The future")
    eventually(XCTAssertEqual("The future", self.textField.text))

    observer.sendNext("")
    eventually(XCTAssertEqual("", self.textField.text))
  }
}
