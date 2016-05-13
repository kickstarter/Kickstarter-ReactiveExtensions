import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIResponderTests: XCTestCase {
  let window = UIWindow()
  let responder = UITextView()

  override func setUp() {
    super.setUp()
    self.window.addSubview(self.responder)
  }

  func testIsFirstResponder() {

    let (signal, observer) = Signal<Bool, NoError>.pipe()
    responder.rac.isFirstResponder = signal

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.responder.isFirstResponder()))

    observer.sendNext(false)
    eventually(XCTAssertFalse(self.responder.isFirstResponder()))

    observer.sendNext(true)
    eventually(XCTAssertTrue(self.responder.isFirstResponder()))
  }
}
