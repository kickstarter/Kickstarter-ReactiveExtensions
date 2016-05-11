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
    async { done in
      XCTAssertEqual(0.0, self.view.alpha)
      done()
    }

    observer.sendNext(0.5)
    async { done in
      XCTAssertEqual(0.5, self.view.alpha)
      done()
    }
  }

  func testBackgroundColor() {
    let (signal, observer) = Signal<UIColor, NoError>.pipe()
    view.rac.backgroundColor = signal

    observer.sendNext(.redColor())
    async { done in
      XCTAssertEqual(.redColor(), self.view.backgroundColor)
      done()
    }

    observer.sendNext(.greenColor())
    async { done in
      XCTAssertEqual(.greenColor(), self.view.backgroundColor)
      done()
    }
  }

  func testHidden() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    view.rac.hidden = signal

    observer.sendNext(true)
    async { done in
      XCTAssertTrue(self.view.hidden)
      done()
    }

    observer.sendNext(false)
    async { done in
      XCTAssertFalse(self.view.hidden)
      done()
    }

    observer.sendNext(true)
    async { done in
      XCTAssertTrue(self.view.hidden)
      done()
    }
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
