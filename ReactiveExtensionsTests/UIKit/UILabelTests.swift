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

  func testFont() {
    let (signal, observer) = Signal<UIFont, NoError>.pipe()
    label.rac.font = signal

    let font = UIFont.systemFontOfSize(16.0)
    observer.sendNext(font)
    XCTAssertEqual(font, label.font)
  }

  func testTextColor() {
    let (signal, observer) = Signal<UIColor, NoError>.pipe()
    label.rac.textColor = signal

    let color = UIColor.redColor()
    observer.sendNext(color)
    XCTAssertEqual(color, label.textColor)
  }
}
