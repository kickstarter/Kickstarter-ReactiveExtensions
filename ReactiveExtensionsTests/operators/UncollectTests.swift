import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

class UncollectTests : XCTestCase {

  func testSignalUncollect() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])

    XCTAssertEqual(test.nextValues, [1, 2, 3])
    XCTAssertFalse(test.didComplete)

    observer.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testSignalUncollectFailure() {
    let (signal, observer) = Signal<[Int], SomeError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, SomeError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])
    observer.sendFailed(SomeError())
    
    XCTAssertEqual(test.nextValues, [1, 2, 3])
    XCTAssertTrue(test.didFail)
  }

  func testSignalUncollectInterruption() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let uncollected = signal.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.observe(test.observer)

    observer.sendNext([1, 2, 3])
    observer.sendInterrupted()
    
    XCTAssertEqual(test.nextValues, [1, 2, 3])
    XCTAssertTrue(test.didInterrupt)
  }

  func testSignalProducerUncollect() {
    let producer = SignalProducer<[Int], NoError>(value: [1, 2, 3])
    let uncollected = producer.uncollect()
    let test = TestObserver<Int, NoError>()
    uncollected.start(test.observer)

    XCTAssertEqual(test.nextValues, [1, 2, 3])
  }
}
