import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIViewTests: XCTestCase {

  let view = UIView()

  func testAlpha() {
    let (signal, observer) = Signal<CGFloat, NoError>.pipe()
    view.rac.alpha = signal

    observer.sendNext(0.0)
    eventually(XCTAssertEqual(0.0, self.view.alpha))

    observer.sendNext(0.5)
    eventually(XCTAssertEqual(0.5, self.view.alpha))
  }

  func testBackgroundColor() {
    let (signal, observer) = Signal<UIColor, NoError>.pipe()
    view.rac.backgroundColor = signal

    observer.sendNext(.redColor())
    eventually(XCTAssertEqual(.redColor(), self.view.backgroundColor))

    observer.sendNext(.greenColor())
    eventually(XCTAssertEqual(.greenColor(), self.view.backgroundColor))
  }

  func testEndEditing() {
    let (signal, observer) = Signal<(), NoError>.pipe()
    #if os(iOS)
    let view = UITextView()
    #else
    let view = UIButton()
    #endif

    let window = UIWindow()
    window.addSubview(view)
    view.becomeFirstResponder()

    view.rac.endEditing = signal

    eventually(XCTAssertTrue(view.isFirstResponder()))

    observer.sendNext()
    eventually(XCTAssertFalse(view.isFirstResponder()))
  }

  func testHidden() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    view.rac.hidden = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.view.hidden))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.view.hidden))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.view.hidden))
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

    let (signal, observer) = Signal<CGFloat, NoError>.pipe()
    view.rac.alpha = signal

    let expectation = expectationWithDescription("isMainThread")
    view.callback = {
      XCTAssertTrue(NSThread.isMainThread())
      expectation.fulfill()
    }
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
      observer.sendNext(0.5)
    }
    waitForExpectationsWithTimeout(0.1, handler: nil)
    XCTAssertEqual(0.5, view.alpha)
  }
}
