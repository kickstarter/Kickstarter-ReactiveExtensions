import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITextFieldTests: XCTestCase {
  let textField = UITextField()

  func testText() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    textField.rac.text = signal

    observer.send(value: "The future")
    eventually(XCTAssertEqual("The future", self.textField.text))

    observer.send(value: "")
    eventually(XCTAssertEqual("", self.textField.text))
  }
}
