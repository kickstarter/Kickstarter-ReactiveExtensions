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
    let property = MutableProperty<Int>(0)
    let test = TestObserver<SomeError, NoError>()
    property.producer
      .flatMap { idx in failOnEvens(idx).materialize() }
      .errors()
      .start(test.observer)

    property.value = 1
    property.value = 2
    property.value = 3
    property.value = 4
    property.producer.startWithCompleted {
      test.assertValueCount(3)
    }
  }
}
