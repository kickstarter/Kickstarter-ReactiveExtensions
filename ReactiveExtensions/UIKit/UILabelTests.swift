import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UILabelTests: XCTestCase {
  let label = UILabel()

  func testText() {
    let (signal, observer) = Signal<String, Never>.pipe()
    label.rac.text = signal

    observer.send(value: "The future")
    eventually(XCTAssertEqual("The future", self.label.text))

    observer.send(value: "")
    eventually(XCTAssertEqual("", self.label.text))
  }

  func testFont() {
    let (signal, observer) = Signal<UIFont, Never>.pipe()
    label.rac.font = signal

    let font = UIFont.systemFont(ofSize: 16.0)

    observer.send(value: font)
    eventually(XCTAssertEqual(font, self.label.font))
  }

  func testTextColor() {
    let (signal, observer) = Signal<UIColor, Never>.pipe()
    label.rac.textColor = signal

    let color = UIColor.red

    observer.send(value: color)
    eventually(XCTAssertEqual(color, self.label.textColor))
  }
}
