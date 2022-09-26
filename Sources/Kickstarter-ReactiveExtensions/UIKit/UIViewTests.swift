import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIViewTests: XCTestCase {

  let view = UIView()

  func testAlpha() {
    let (signal, observer) = Signal<CGFloat, Never>.pipe()
    view.rac.alpha = signal

    observer.send(value: 0.0)
    eventually(XCTAssertEqual(0.0, self.view.alpha))

    observer.send(value: 0.5)
    eventually(XCTAssertEqual(0.5, self.view.alpha))
  }

  func testBackgroundColor() {
    let (signal, observer) = Signal<UIColor, Never>.pipe()
    view.rac.backgroundColor = signal

    observer.send(value: .red)
    eventually(XCTAssertEqual(.red, self.view.backgroundColor))

    observer.send(value: .green)
    eventually(XCTAssertEqual(.green, self.view.backgroundColor))
  }

  func testEndEditing() {
    let (signal, observer) = Signal<(), Never>.pipe()
    #if os(iOS)
    let view = UITextView()
    #else
    let view = UIButton()
    #endif

    let window = UIWindow()
    window.addSubview(view)
    view.becomeFirstResponder()

    view.rac.endEditing = signal

    eventually(XCTAssertTrue(view.isFirstResponder))

    observer.send(value: ())
    eventually(XCTAssertFalse(view.isFirstResponder))
  }

  func testHidden() {
    let (signal, observer) = Signal<Bool, Never>.pipe()
    view.rac.hidden = signal

    observer.send(value: true)
    eventually(XCTAssertTrue(self.view.isHidden))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.view.isHidden))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.view.isHidden))
  }

  private final class MockView: UIView {
    var callback: () -> Void = {}

    override var alpha: CGFloat {
      get { return super.alpha }
      set { callback(); super.alpha = newValue }
    }
  }

  // this is not exhaustive (each individual binding must call `observeForUI()`)
  func testIsMainThread() {
    let view = MockView()

    let (signal, observer) = Signal<CGFloat, Never>.pipe()
    view.rac.alpha = signal

    let expectation = self.expectation(description: "isMainThread")
    view.callback = {
      XCTAssertTrue(Thread.isMainThread)
      expectation.fulfill()
    }
    DispatchQueue.global(qos: .background).async {
      observer.send(value: 0.5)
    }
    waitForExpectations(timeout: 1, handler: nil)
    XCTAssertEqual(0.5, view.alpha)
  }
}
