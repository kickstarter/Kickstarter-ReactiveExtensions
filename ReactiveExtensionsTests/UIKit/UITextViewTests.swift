import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITextViewTests: XCTestCase {
  let textView = UITextView()

  func testText() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    textView.rac.text = signal

    observer.sendNext("The future")
    eventually(XCTAssertEqual("The future", self.textView.text))

    observer.sendNext("")
    eventually(XCTAssertEqual("", self.textView.text))
  }
}
