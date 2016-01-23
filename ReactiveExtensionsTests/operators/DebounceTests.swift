import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class DebounceTests : XCTestCase {

  func testDebounce() {
    let scheduler = TestScheduler()
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let debounced = signal.debounce(0.5, onScheduler: scheduler)
    let test = debounced.testObserve()

    observer.sendNext(1)
    XCTAssertEqual(test.nextValues, [])

    observer.sendNext(2)
    XCTAssertEqual(test.nextValues, [])

    scheduler.advanceByInterval(0.3)
    XCTAssertEqual(test.nextValues, [])

    observer.sendNext(3)
    XCTAssertEqual(test.nextValues, [])

    scheduler.advanceByInterval(0.8)
    XCTAssertEqual(test.nextValues, [3])

    observer.sendNext(4)
    XCTAssertEqual(test.nextValues, [3])

    scheduler.advanceByInterval(0.6)
    XCTAssertEqual(test.nextValues, [3, 4])
  }
}
