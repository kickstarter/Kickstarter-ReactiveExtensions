import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class BackgroundTests: XCTestCase {

  func testSignal_Background() {
    let (s, o) = Signal<Int, NoError>.pipe()

    s.observeForBackground().observeNext { (value) in
      XCTAssertFalse(NSThread.isMainThread())
    }

    s.observeForBackground(DISPATCH_QUEUE_PRIORITY_BACKGROUND).observeNext { (value) in
      XCTAssertFalse(NSThread.isMainThread())
    }

    o.sendNext(1)
  }
}
