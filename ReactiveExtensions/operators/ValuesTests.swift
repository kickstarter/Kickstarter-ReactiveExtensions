import XCTest
import ReactiveSwift
import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

private func failOnEvens(_ idx: Int) -> SignalProducer<Int, SomeError> {
  return idx % 2 == 0 ? SignalProducer(error: SomeError()) : SignalProducer(value: idx)
}

final class ValuesTests: XCTestCase {

  func testSignalValues() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let test = TestObserver<Int, Never>()
    signal
      .flatMap { idx in failOnEvens(idx).materialize() }
      .values()
      .observe(test.observer)

    observer.send(value: 0)
    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(value: 4)
    observer.sendCompleted()

    test.assertValues([1, 3])
  }

  func testProducerValues() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let producer = SignalProducer(signal)
    let test = TestObserver<Int, Never>()
    producer
      .flatMap { idx in failOnEvens(idx).materialize() }
      .values()
      .start(test.observer)

    observer.send(value: 0)
    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(value: 4)
    observer.sendCompleted()

    test.assertValues([1, 3])
  }
}
