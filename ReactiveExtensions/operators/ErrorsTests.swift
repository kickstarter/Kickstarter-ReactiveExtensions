import XCTest
import ReactiveSwift
import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

private func failOnEvens(_ idx: Int) -> SignalProducer<Int, SomeError> {
  return idx % 2 == 0 ? SignalProducer(error: SomeError()) : SignalProducer(value: idx)
}

final class ErrorsTests: XCTestCase {

  func testSignalErrors() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let test = TestObserver<SomeError, Never>()
    signal
      .flatMap { idx in failOnEvens(idx).materialize() }
      .errors()
      .observe(test.observer)

    observer.send(value: 0)
    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(value: 4)
    observer.sendCompleted()

    test.assertValueCount(3)
  }

  func testProducerValues() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let producer = SignalProducer(signal)
    let test = TestObserver<SomeError, Never>()
    producer
      .flatMap { idx in failOnEvens(idx).materialize() }
      .errors()
      .start(test.observer)

    observer.send(value: 0)
    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(value: 4)
    observer.sendCompleted()

    test.assertValueCount(3)
  }
}
