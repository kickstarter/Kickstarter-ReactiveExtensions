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

  func testDemoteErrors_Producer_WithDefaultArguments() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let producer = SignalProducer(signal: signal)
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
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let producer = SignalProducer(signal: signal)
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
}
