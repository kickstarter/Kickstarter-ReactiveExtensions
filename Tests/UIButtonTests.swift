import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UIButtonTests: XCTestCase {
  private let button = UIButton()

  func testTitle() {
    let (signal, observer) = Signal<String, Never>.pipe()
    button.rac.title = signal

    observer.send(value: "Hello")
    eventually(XCTAssertEqual("Hello", self.button.title(for: .normal)))

    observer.send(value: "Hello World")
    eventually(XCTAssertEqual("Hello World", self.button.title(for: .normal)))

    observer.send(value: "")
    eventually(XCTAssertEqual("", self.button.title(for: .normal)))
  }
}
