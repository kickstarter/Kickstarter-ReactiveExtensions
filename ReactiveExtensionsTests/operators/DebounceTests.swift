import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class DebounceTests : XCTestCase {

  func testDebounce() {
    let scheduler = TestScheduler()
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let debounced = signal.debounce(0.5, onScheduler: scheduler)
    let testObserver = TestObserver<Int, NoError>()
    debounced.observe(testObserver.observer)

    observer.sendNext(1)
    XCTAssertFalse(testObserver.didEmitValue)

    observer.sendNext(2)
    XCTAssertFalse(testObserver.didEmitValue)

    scheduler.advanceByInterval(0.3)
    XCTAssertFalse(testObserver.didEmitValue)

    observer.sendNext(3)
    XCTAssertFalse(testObserver.didEmitValue)

    scheduler.advanceByInterval(0.8)
    XCTAssertEqual(testObserver.nextValues, [3])

    observer.sendNext(4)
    XCTAssertEqual(testObserver.nextValues, [3])

    scheduler.advanceByInterval(0.6)
    XCTAssertEqual(testObserver.nextValues, [3, 4])
  }
}
