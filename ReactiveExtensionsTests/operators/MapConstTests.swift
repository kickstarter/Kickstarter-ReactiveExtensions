import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class MapConstTests : XCTestCase {

  func testSignalMapConst() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let const = signal.mapConst(5)
    let test = const.testObserve()

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendNext(4)

    XCTAssertEqual(test.nextValues, [5, 5, 5, 5])
  }

  func testSignalProducerMapConst() {
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .mapConst(5)

    XCTAssertEqual(producer.allValues(), [5, 5, 5, 5])
  }
}
