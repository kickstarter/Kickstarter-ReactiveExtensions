import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

class UncollectTests : XCTestCase {

  func testSignalUncollect() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])

    test.assertValues([1, 2, 3])
    test.assertDidNotComplete()

    observer.sendCompleted()
    test.assertDidComplete()
  }

  func testSignalUncollectFailure() {
    let (signal, observer) = Signal<[Int], SomeError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, SomeError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])
    observer.sendFailed(SomeError())
    
    test.assertValues([1, 2, 3])
    test.assertDidFail()
  }

  func testSignalUncollectInterruption() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])
    observer.sendInterrupted()
    
    test.assertValues([1, 2, 3])
    test.assertDidInterrupt()
  }

  func testSignalProducerUncollect() {
    let producer = SignalProducer<[Int], NoError>(value: [1, 2, 3])
    let uncollected = producer.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.start(test.observer)

    test.assertValues([1, 2, 3])
  }
}
