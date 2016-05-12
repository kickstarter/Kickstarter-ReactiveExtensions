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
    eventually(XCTAssertEqual("The future", self.label.text))

    observer.sendNext("")
    eventually(XCTAssertEqual("", self.label.text))
  }

  func testFont() {
    let (signal, observer) = Signal<UIFont, NoError>.pipe()
    label.rac.font = signal

    let font = UIFont.systemFontOfSize(16.0)

    observer.sendNext(font)
    eventually(XCTAssertEqual(font, self.label.font))
  }

  func testTextColor() {
    let (signal, observer) = Signal<UIColor, NoError>.pipe()
    label.rac.textColor = signal

    let color = UIColor.redColor()

    observer.sendNext(color)
    eventually(XCTAssertEqual(color, self.label.textColor))
  }
}
