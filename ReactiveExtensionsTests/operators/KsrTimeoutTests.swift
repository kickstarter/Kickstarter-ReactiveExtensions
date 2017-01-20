import XCTest
import ReactiveSwift
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class KsrTimeoutTests: XCTestCase {

  func testTimeout_GetsValueInTime() {
    let scheduler = TestScheduler()
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let debounced = signal.ksr_timeout(after: .seconds(1), on: scheduler)
    let test = TestObserver<Int, NoError>()
    debounced.observe(test.observer)

    scheduler.advance(by: .milliseconds(500))

    observer.send(value: 1)

    test.assertValues([1])
    test.assertDidNotComplete()

    scheduler.advance(by: .milliseconds(500))

    test.assertValues([1])
    test.assertDidComplete()
  }

  func testTimeout_DoesntGetValueInTime() {
    let scheduler = TestScheduler()
    let (signal, _) = Signal<Int, NoError>.pipe()
    let debounced = signal.ksr_timeout(after: .seconds(1), on: scheduler)
    let test = TestObserver<Int, NoError>()
    debounced.observe(test.observer)

    scheduler.advance(by: .milliseconds(500))

    test.assertDidNotComplete()

    scheduler.advance(by: .milliseconds(500))
    
    test.assertDidComplete()
  }
}
