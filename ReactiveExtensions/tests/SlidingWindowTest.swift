import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class SlidingWindowTest: XCTestCase {

  func testSlidingWindowWithMaxLessThanMin() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let window = signal.slidingWindow(max: 3, min: 2)
    let test = TestObserver<[Int], Never>()
    window.observe(test.observer)

    observer.send(value: 1)
    test.assertValues([])

    observer.send(value: 2)
    test.assertValues([[1, 2]])

    observer.send(value: 3)
    test.assertValues([[1, 2], [1, 2, 3]])

    observer.send(value: 4)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4]])

    observer.send(value: 5)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

  func testSlidingWindowWithMinEqualToZero() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let window = signal.slidingWindow(max: 2, min: 0)
    let test = TestObserver<[Int], Never>()
    window.observe(test.observer)

    observer.send(value: 1)
    test.assertValues([[1]])

    observer.send(value: 2)
    test.assertValues([[1], [1, 2]])

    observer.send(value: 3)
    test.assertValues([[1], [1, 2], [2, 3]])

    observer.send(value: 4)
    test.assertValues([[1], [1, 2], [2, 3], [3, 4]])
  }

  func testSlidingWindowWithMaxEqualToMin() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let window = signal.slidingWindow(max: 3, min: 3)
    let test = TestObserver<[Int], Never>()
    window.observe(test.observer)

    observer.send(value: 1)
    test.assertValues([])

    observer.send(value: 2)
    test.assertValues([])

    observer.send(value: 3)
    test.assertValues([[1, 2, 3]])

    observer.send(value: 4)
    test.assertValues([[1, 2, 3], [2, 3, 4]])

    observer.send(value: 5)
    test.assertValues([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

  func testProducer_SlidingWindowWithMaxLessThanMin() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let producer = SignalProducer(signal)
    let window = producer.slidingWindow(max: 3, min: 2)
    let test = TestObserver<[Int], Never>()
    window.start(test.observer)

    observer.send(value: 1)
    test.assertDidNotEmitValue()

    observer.send(value: 2)
    test.assertValues([[1, 2]])

    observer.send(value: 3)
    test.assertValues([[1, 2], [1, 2, 3]])

    observer.send(value: 4)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4]])

    observer.send(value: 5)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])

    observer.sendCompleted()
    test.assertDidComplete()
  }
}
