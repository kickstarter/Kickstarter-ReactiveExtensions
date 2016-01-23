import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

class BeginsWithTests : XCTestCase {

  func testBeingsWithValue() {
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3])
    let beginsWith0 = producer.beginsWith(value: 0)

    XCTAssertEqual(beginsWith0.allValues(), [0, 1, 2, 3])
  }

  func testBeingsWithValues() {
    let producer = SignalProducer<Int, NoError>(values: [2, 3])
    let beginsWith0 = producer.beginsWith(values: [0, 1])

    XCTAssertEqual(beginsWith0.allValues(), [0, 1, 2, 3])
  }
}
