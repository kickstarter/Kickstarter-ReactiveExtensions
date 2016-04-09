import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DemoteErrorTests: XCTestCase {

  func testDemoteErrors_Signal_WithDefaultArguements() {
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

  func testDemoteErrors_Signal_WithReplacementValue() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let testSignal = signal.demoteErrors(replaceErrorWith: 99)

    let test = TestObserver<Int, NoError>()
    testSignal.observe(test.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testDemoteErrors_Signal_WithErrorsProperty() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let errors = MutableProperty<SomeError?>(nil)
    let testSignal = signal.demoteErrors(pipeErrorsTo: errors)

    let test = TestObserver<Int, NoError>()
    testSignal.observe(test.observer)

    let errorTest = TestObserver<SomeError?, NoError>()
    errors.signal.observe(errorTest.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()

    errorTest.assertValueCount(1)
    errorTest.assertDidNotComplete()
    errorTest.assertDidNotFail()
  }


  func testDemoteErrors_Signal_WithReplacementAndErrorsProperty() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let errors = MutableProperty<SomeError?>(nil)
    let testSignal = signal.demoteErrors(replaceErrorWith: 99, pipeErrorsTo: errors)

    let test = TestObserver<Int, NoError>()
    testSignal.observe(test.observer)

    let errorTest = TestObserver<SomeError?, NoError>()
    errors.signal.observe(errorTest.observer)

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

  func testDemoteErrors_Producer_WithDefaultArguements() {
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

  func testDemoteErrors_Producer_WithReplacementValue() {
    let (producer, observer) = SignalProducer<Int, SomeError>.buffer(0)
    let testSignal = producer.demoteErrors(replaceErrorWith: 99)

    let test = TestObserver<Int, NoError>()
    testSignal.start(test.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testDemoteErrors_Producer_WithErrorsProperty() {
    let (producer, observer) = SignalProducer<Int, SomeError>.buffer(0)
    let errors = MutableProperty<SomeError?>(nil)
    let testSignal = producer.demoteErrors(pipeErrorsTo: errors)

    let test = TestObserver<Int, NoError>()
    testSignal.start(test.observer)

    let errorTest = TestObserver<SomeError?, NoError>()
    errors.signal.observe(errorTest.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendFailed(SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()

    errorTest.assertValueCount(1)
    errorTest.assertDidNotComplete()
    errorTest.assertDidNotFail()
  }


  func testDemoteErrors_Producer_WithReplacementAndErrorsProperty() {
    let (producer, observer) = SignalProducer<Int, SomeError>.buffer(0)
    let errors = MutableProperty<SomeError?>(nil)
    let testSignal = producer.demoteErrors(replaceErrorWith: 99, pipeErrorsTo: errors)

    let test = TestObserver<Int, NoError>()
    testSignal.start(test.observer)

    let errorTest = TestObserver<SomeError?, NoError>()
    errors.signal.observe(errorTest.observer)

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
