import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class AllValuesTests: XCTestCase {

  func testAllValues() {
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
    XCTAssertEqual([1, 2, 3, 4], producer.allValues())
  }
}
