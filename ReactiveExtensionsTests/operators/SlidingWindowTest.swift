import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class SlidingWindowTest : XCTestCase {

  func testSlidingWindowWithMaxLessThanMin() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 3, min: 2)
    let test = window.testObserve()

    observer.sendNext(1)
    XCTAssertEqual(test.nextValues, [])
    observer.sendNext(2)
    XCTAssertEqual(test.nextValues, [[1, 2]])
    observer.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 2], [1, 2, 3]])
    observer.sendNext(4)
    XCTAssertEqual(test.nextValues, [[1, 2], [1, 2, 3], [2, 3, 4]])
    observer.sendNext(5)
    XCTAssertEqual(test.nextValues, [[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

  func testSlidingWindowWithMinEqualToZero() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 2, min: 0)
    let test = window.testObserve()

    observer.sendNext(1)
    XCTAssertEqual(test.nextValues, [[1]])
    observer.sendNext(2)
    XCTAssertEqual(test.nextValues, [[1], [1, 2]])
    observer.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1], [1, 2], [2, 3]])
    observer.sendNext(4)
    XCTAssertEqual(test.nextValues, [[1], [1, 2], [2, 3], [3, 4]])
  }

  func testSlidingWindowWithMaxEqualToMin() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let window = signal.slidingWindow(max: 3, min: 3)
    let test = window.testObserve()

    observer.sendNext(1)
    XCTAssertEqual(test.nextValues, [])
    observer.sendNext(2)
    XCTAssertEqual(test.nextValues, [])
    observer.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 2, 3]])
    observer.sendNext(4)
    XCTAssertEqual(test.nextValues, [[1, 2, 3], [2, 3, 4]])
    observer.sendNext(5)
    XCTAssertEqual(test.nextValues, [[1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

  func testProducer_SlidingWindowWithMaxLessThanMin() {
    let (producer, observer) = SignalProducer<Int, NoError>.buffer()
    let window = producer.slidingWindow(max: 3, min: 2)

    observer.sendNext(1)
    XCTAssertEqual(window.allValues(), [])
    observer.sendNext(2)
    XCTAssertEqual(window.allValues(), [[1, 2]])
    observer.sendNext(3)
    XCTAssertEqual(window.allValues(), [[1, 2], [1, 2, 3]])
    observer.sendNext(4)
    XCTAssertEqual(window.allValues(), [[1, 2], [1, 2, 3], [2, 3, 4]])
    observer.sendNext(5)
    XCTAssertEqual(window.allValues(), [[1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]])
  }

}
