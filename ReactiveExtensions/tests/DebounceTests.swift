import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DebounceTests: XCTestCase {

  func testDebounce() {
    let scheduler = TestScheduler()
    let (signal, observer) = Signal<Int, Never>.pipe()
    let debounced = signal.ksr_debounce(.milliseconds(500), on: scheduler)
    let test = TestObserver<Int, Never>()
    debounced.observe(test.observer)

    observer.send(value: 1)
    test.assertDidNotEmitValue()

    observer.send(value: 2)
    test.assertDidNotEmitValue()

    scheduler.advance(by: .milliseconds(300))
    test.assertDidNotEmitValue()

    observer.send(value: 3)
    test.assertDidNotEmitValue()

    scheduler.advance(by: .milliseconds(800))
    test.assertValues([3])

    observer.send(value: 4)
    test.assertValues([3])

    scheduler.advance(by: .milliseconds(600))
    test.assertValues([3, 4])
  }
}
