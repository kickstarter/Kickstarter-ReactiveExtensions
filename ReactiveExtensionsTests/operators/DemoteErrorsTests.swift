import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DemoteErrorTests: XCTestCase {

  func testSignal_DemoteErrorsWithDefaultArgs() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let testSignal = signal.demoteErrors()
    let test = TestObserver<Int, NoError>()
    testSignal.observe(test.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testSignal_DemoteErrorsWithArgs() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let (errors, errorObserver) = Signal<SomeError, NoError>.pipe()
    let testSignal = signal.demoteErrors(replaceErrorWith: 99, pipeErrorsTo: errorObserver)

    let test = TestObserver<Int, NoError>()
    testSignal.observe(test.observer)

    let errorTest = TestObserver<SomeError, NoError>()
    errors.observe(errorTest.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()

    errorTest.assertValueCount(1)
    errorTest.assertDidNotComplete()
    errorTest.assertDidNotFail()
  }

  func testProducer_DemoteErrorsWithDefaultArgs() {
    let (producer, observer) = SignalProducer<Int, SomeError>.buffer(0)
    let testSignal = producer.demoteErrors()
    let test = TestObserver<Int, NoError>()
    testSignal.start(test.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testProducer_DemoteErrorsWithArgs() {
    let (producer, observer) = SignalProducer<Int, SomeError>.buffer(0)
    let (errors, errorObserver) = Signal<SomeError, NoError>.pipe()
    let testSignal = producer.demoteErrors(replaceErrorWith: 99, pipeErrorsTo: errorObserver)

    let test = TestObserver<Int, NoError>()
    testSignal.start(test.observer)

    let errorTest = TestObserver<SomeError, NoError>()
    errors.observe(errorTest.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()

    errorTest.assertValueCount(1)
    errorTest.assertDidNotComplete()
    errorTest.assertDidNotFail()
  }
}
