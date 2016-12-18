import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITextViewTests: XCTestCase {
  let textView = UITextView()

  func testText() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    textView.rac.text = signal

    observer.send(value: "The future")
    eventually(XCTAssertEqual("The future", self.textView.text))

    observer.send(value: "")
    eventually(XCTAssertEqual("", self.textView.text))
  }
}
