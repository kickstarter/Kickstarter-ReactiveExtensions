import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIResponderTests: XCTestCase {
  let window = UIWindow()
  #if os(iOS)
  let responder = UITextView()
  #else
  let responder = UIButton()
  #endif

  override func setUp() {
    super.setUp()
    self.window.addSubview(self.responder)
  }

  func testBecomeFirstResponder() {
    let (signal, observer) = Signal<(), NoError>.pipe()
    responder.rac.becomeFirstResponder = signal

    eventually(XCTAssertFalse(self.responder.isFirstResponder))

    observer.send(value: ())
    eventually(XCTAssertTrue(self.responder.isFirstResponder))
  }

  func testIsFirstResponder() {

    let (signal, observer) = Signal<Bool, NoError>.pipe()
    responder.rac.isFirstResponder = signal

    eventually(XCTAssertFalse(self.responder.isFirstResponder))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.responder.isFirstResponder))

    observer.send(value: false)
    eventually(XCTAssertFalse(self.responder.isFirstResponder))

    observer.send(value: true)
    eventually(XCTAssertTrue(self.responder.isFirstResponder))
  }
}
