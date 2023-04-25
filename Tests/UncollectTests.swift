import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

class UncollectTests: XCTestCase {

  func testSignalUncollect() {
    let (signal, observer) = Signal<[Int], Never>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, Never>()
    uncollected.observe(test.observer)

    observer.send(value: [1, 2, 3])

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

    observer.send(value: [1, 2, 3])
    observer.send(error: SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidFail()
  }

  func testSignalUncollectInterruption() {
    let (signal, observer) = Signal<[Int], Never>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, Never>()
    uncollected.observe(test.observer)

    observer.send(value: [1, 2, 3])
    observer.sendInterrupted()

    test.assertValues([1, 2, 3])
    test.assertDidInterrupt()
  }

  func testSignalProducerUncollect() {
    let producer = SignalProducer<[Int], Never>(value: [1, 2, 3])
    let uncollected = producer.uncollect()
    let test = TestObserver<Int, Never>()
    uncollected.start(test.observer)

    test.assertValues([1, 2, 3])
  }
}
