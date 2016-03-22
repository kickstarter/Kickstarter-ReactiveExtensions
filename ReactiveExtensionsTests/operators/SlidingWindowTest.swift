import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class SlidingWindowTest : XCTestCase {

  func testSlidingWindowWithMaxLessThanMin() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 3, min: 2)
    let test = TestObserver<[Int], NoError>()
    window.observe(test.observer)

    observer.sendNext(1)
    test.assertValues([])

    observer.sendNext(2)
    test.assertValues([[1, 2]])

    observer.sendNext(3)
    test.assertValues([[1, 2], [1, 2, 3]])

    observer.sendNext(4)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4]])

    observer.sendNext(5)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

  func testSlidingWindowWithMinEqualToZero() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 2, min: 0)
    let test = TestObserver<[Int], NoError>()
    window.observe(test.observer)

    observer.sendNext(1)
    test.assertValues([[1]])

    observer.sendNext(2)
    test.assertValues([[1], [1, 2]])

    observer.sendNext(3)
    test.assertValues([[1], [1, 2], [2, 3]])

    observer.sendNext(4)
    test.assertValues([[1], [1, 2], [2, 3], [3, 4]])
  }

  func testSlidingWindowWithMaxEqualToMin() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 3, min: 3)
    let test = TestObserver<[Int], NoError>()
    window.observe(test.observer)

    observer.sendNext(1)
    test.assertValues([])

    observer.sendNext(2)
    test.assertValues([])

    observer.sendNext(3)
    test.assertValues([[1, 2, 3]])

    observer.sendNext(4)
    test.assertValues([[1, 2, 3], [2, 3, 4]])

    observer.sendNext(5)
    test.assertValues([[1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }
  
  func testProducer_SlidingWindowWithMaxLessThanMin() {
    let (producer, observer) = SignalProducer<Int, NoError>.buffer(Int.max)
    let window = producer.slidingWindow(max: 3, min: 2)
    let test = TestObserver<[Int], NoError>()
    window.start(test.observer)

    observer.sendNext(1)
    test.assertDidNotEmitValue()
    
    observer.sendNext(2)
    test.assertValues([[1, 2]])
    
    observer.sendNext(3)
    test.assertValues([[1, 2], [1, 2, 3]])
    
    observer.sendNext(4)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4]])
    
    observer.sendNext(5)
    test.assertValues([[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])
    
    observer.sendCompleted()
    test.assertDidComplete()
  }
}
