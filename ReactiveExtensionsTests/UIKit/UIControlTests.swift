import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UIControlTests: XCTestCase {

  let control = UIControl()

  func testEnabled() {
    let (signal, observer) = Signal<Bool, NoError>.pipe()
    control.rac.enabled = signal

    observer.sendNext(true)
    async { done in
      XCTAssertTrue(self.control.enabled)
      done()
    }

    observer.sendNext(false)
    async { done in
      XCTAssertFalse(self.control.enabled)
      done()
    }

    observer.sendNext(true)
    async { done in
      XCTAssertTrue(self.control.enabled)
      done()
    }
  }
}
