import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DebounceTests: XCTestCase {

  func testDebounce() {
    let scheduler = TestScheduler()
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let debounced = signal.debounce(0.5, onScheduler: scheduler)
    let test = TestObserver<Int, NoError>()
    debounced.observe(test.observer)

    observer.sendNext(1)
    test.assertDidNotEmitValue()

    observer.sendNext(2)
    test.assertDidNotEmitValue()

    scheduler.advanceByInterval(0.3)
    test.assertDidNotEmitValue()

    observer.sendNext(3)
    test.assertDidNotEmitValue()

    scheduler.advanceByInterval(0.8)
    test.assertValues([3])

    observer.sendNext(4)
    test.assertValues([3])

    scheduler.advanceByInterval(0.6)
    test.assertValues([3, 4])
  }
}
