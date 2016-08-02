import XCTest
import ReactiveCocoa
import Result
import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

private func failOnEvens(idx: Int) -> SignalProducer<Int, SomeError> {
  return idx % 2 == 0 ? SignalProducer(error: SomeError()) : SignalProducer(value: idx)
}

final class ErrorsTests: XCTestCase {

  func testSignalErrors() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let test = TestObserver<SomeError, NoError>()
    signal
      .flatMap { idx in failOnEvens(idx).materialize() }
      .errors()
      .observe(test.observer)

    observer.sendNext(0)
    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendNext(4)
    observer.sendCompleted()

    test.assertValueCount(3)
  }

  func testProducerValues() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let producer = SignalProducer(signal: signal)
    let test = TestObserver<SomeError, NoError>()
    producer
      .flatMap { idx in failOnEvens(idx).materialize() }
      .errors()
      .start(test.observer)

    observer.sendNext(0)
    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendNext(4)
    observer.sendCompleted()

    test.assertValueCount(3)
  }
}
