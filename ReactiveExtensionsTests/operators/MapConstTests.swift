import XCTest
import ReactiveSwift
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class MapConstTests: XCTestCase {

  func testSignalMapConst() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let const = signal.mapConst(5)
    let test = TestObserver<Int, NoError>()
    const.observe(test.observer)

    observer.send(value: 1)
    test.assertValues([5])

    observer.send(value: 2)
    test.assertValues([5, 5])

    observer.send(value: 3)
    test.assertValues([5, 5, 5])

    observer.send(value: 4)
    test.assertValues([5, 5, 5, 5])
  }

  func testSignalProducerMapConst() {
    let producer = SignalProducer<Int, NoError>([1, 2, 3, 4])
      .mapConst(5)
    let test = TestObserver<Int, NoError>()
    producer.start(test.observer)

    test.assertValues([5, 5, 5, 5])
  }
}
