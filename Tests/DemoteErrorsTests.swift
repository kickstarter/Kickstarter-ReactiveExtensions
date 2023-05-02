import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DemoteErrorTests: XCTestCase {

  func testDemoteErrors_Signal_WithDefaultArguements() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let testSignal = signal.demoteErrors()

    let test = TestObserver<Int, Never>()
    testSignal.observe(test.observer)

    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(error: SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testDemoteErrors_Signal_WithReplacementValue() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let testSignal = signal.demoteErrors(replaceErrorWith: 99)

    let test = TestObserver<Int, Never>()
    testSignal.observe(test.observer)

    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(error: SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testDemoteErrors_Producer_WithDefaultArguments() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let producer = SignalProducer(signal)
    let testSignal = producer.demoteErrors()

    let test = TestObserver<Int, Never>()
    testSignal.start(test.observer)

    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(error: SomeError())

    test.assertValues([1, 2, 3])
    test.assertDidNotFail()
    test.assertDidComplete()
  }

  func testDemoteErrors_Producer_WithReplacementValue() {
    let (signal, observer) = Signal<Int, SomeError>.pipe()
    let producer = SignalProducer(signal)
    let testSignal = producer.demoteErrors(replaceErrorWith: 99)

    let test = TestObserver<Int, Never>()
    testSignal.start(test.observer)

    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(error: SomeError())

    test.assertValues([1, 2, 3, 99])
    test.assertDidNotFail()
    test.assertDidComplete()
  }
}
