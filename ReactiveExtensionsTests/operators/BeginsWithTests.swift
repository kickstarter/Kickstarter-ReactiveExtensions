import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

class BeginsWithTests : XCTestCase {

  func testBeingsWithValue() {
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3])
    let beginsWith0 = producer.beginsWith(value: 0)
    let test = TestObserver<Int, NoError>()
    beginsWith0.start(test.observer)

    XCTAssertEqual(test.nextValues, [0, 1, 2, 3])
  }

  func testBeingsWithValues() {
    let producer = SignalProducer<Int, NoError>(values: [2, 3])
    let beginsWith01 = producer.beginsWith(values: [0, 1])
    let test = TestObserver<Int, NoError>()
    beginsWith01.start(test.observer)

    XCTAssertEqual(test.nextValues, [0, 1, 2, 3])
  }
}
