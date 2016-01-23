import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

class UncollectTests : XCTestCase {

  func testSignalUncollect() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let uncollectedTest = uncollected.testObserve()

    observer.sendNext([1, 2, 3])

    XCTAssertEqual(uncollectedTest.nextValues, [1, 2, 3])
    XCTAssert(!uncollectedTest.didComplete)

    observer.sendCompleted()
    XCTAssert(uncollectedTest.didComplete)
  }

  func testSignalUncollectFailure() {
    let (signal, observer) = Signal<[Int], SomeError>.pipe()
    let uncollected = signal.uncollect()
    let uncollectedTest = uncollected.testObserve()

    observer.sendNext([1, 2, 3])
    observer.sendFailed(SomeError())

    XCTAssert(uncollectedTest.didFail)
  }

  func testSignalUncollectInterruption() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let uncollectedTest = uncollected.testObserve()

    observer.sendNext([1, 2, 3])
    observer.sendInterrupted()

    XCTAssert(uncollectedTest.didInterrupt)
  }

  func testSignalProducerUncollect() {
    let producer = SignalProducer<[Int], NoError>(values: [[1, 2, 3]])
    let uncollected = producer.uncollect()

    XCTAssertEqual(producer.allValues(), [[1, 2, 3]])
    XCTAssertEqual(uncollected.allValues(), [1, 2, 3])
  }
}
