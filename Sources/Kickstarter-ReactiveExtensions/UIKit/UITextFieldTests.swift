import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITextFieldTests: XCTestCase {
  let textField = UITextField()

  func testAttributedPlaceHolder() {
    let (signal, observer) = Signal<NSAttributedString, Never>.pipe()
    textField.rac.attributedPlaceholder = signal

    observer.send(value: NSAttributedString(string: "The future"))
    eventually(XCTAssertEqual("The future", self.textField.attributedPlaceholder?.string))

    observer.send(value: NSAttributedString(string: ""))
    eventually(XCTAssertEqual("", self.textField.attributedPlaceholder?.string))
  }

  func testText() {
    let (signal, observer) = Signal<String, Never>.pipe()
    textField.rac.text = signal

    observer.send(value: "The future")
    eventually(XCTAssertEqual("The future", self.textField.text))

    observer.send(value: "")
    eventually(XCTAssertEqual("", self.textField.text))
  }

  func testTextColor() {
    let (signal, observer) = Signal<UIColor?, Never>.pipe()
    textField.rac.textColor = signal

    observer.send(value: UIColor.red)
    eventually(XCTAssertEqual(UIColor.red, self.textField.textColor))

    observer.send(value: UIColor.green)
    eventually(XCTAssertEqual(UIColor.green, self.textField.textColor))
  }
}
