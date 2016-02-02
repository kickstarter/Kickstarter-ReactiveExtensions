import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class MapConstTests : XCTestCase {

  func testSignalMapConst() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let const = signal.mapConst(5)
    let test = TestObserver<Int, NoError>()
    const.observe(test.observer)

    observer.sendNext(1)
    XCTAssertEqual(test.nextValues, [5])
    
    observer.sendNext(2)
    XCTAssertEqual(test.nextValues, [5, 5])
    
    observer.sendNext(3)
    XCTAssertEqual(test.nextValues, [5, 5, 5])
    
    observer.sendNext(4)
    XCTAssertEqual(test.nextValues, [5, 5, 5, 5])
  }

  func testSignalProducerMapConst() {
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .mapConst(5)
    let test = TestObserver<Int, NoError>()
    producer.start(test.observer)

    XCTAssertEqual(test.nextValues, [5, 5, 5, 5])
  }
}
