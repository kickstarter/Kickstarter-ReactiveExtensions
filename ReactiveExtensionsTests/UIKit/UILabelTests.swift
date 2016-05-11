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
    async { done in
      XCTAssertEqual("The future", self.label.text)
      done()
    }

    observer.sendNext("")
    async { done in
      XCTAssertEqual("", self.label.text)
      done()
    }
  }

  func testFont() {
    let (signal, observer) = Signal<UIFont, NoError>.pipe()
    label.rac.font = signal

    let font = UIFont.systemFontOfSize(16.0)

    observer.sendNext(font)
    async { done in
      XCTAssertEqual(font, self.label.font)
      done()
    }
  }

  func testTextColor() {
    let (signal, observer) = Signal<UIColor, NoError>.pipe()
    label.rac.textColor = signal

    let color = UIColor.redColor()

    observer.sendNext(color)
    async { done in
      XCTAssertEqual(color, self.label.textColor)
      done()
    }
  }
}
