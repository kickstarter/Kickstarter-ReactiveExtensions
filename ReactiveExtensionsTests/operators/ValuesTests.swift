import XCTest
import ReactiveSwift
import Result
import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

private func failOnEvens(_ idx: Int) -> SignalProducer<Int, SomeError> {
  return idx % 2 == 0 ? SignalProducer(error: SomeError()) : SignalProducer(value: idx)
}

final class ValuesTests: XCTestCase {

  func testSignalValues() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let test = TestObserver<Int, NoError>()
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
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let producer = SignalProducer(signal)
    let test = TestObserver<Int, NoError>()
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
