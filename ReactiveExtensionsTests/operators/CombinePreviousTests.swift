import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class CombinePreviousTests : XCTestCase {

  func testCombinePrevious() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let combinePrevious = signal.combinePrevious()
    let combinePreviousTest = combinePrevious.testObserve()

    observer.sendNext(1)
    XCTAssert(!combinePreviousTest.hasEmittedValue)
    observer.sendNext(2)
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.0 }, [1])
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.1 }, [2])
    observer.sendNext(3)
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.0 }, [1, 2])
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.1 }, [2, 3])
    observer.sendNext(4)
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.0 }, [1, 2, 3])
    XCTAssertEqual(combinePreviousTest.nextValues.map { $0.1 }, [2, 3, 4])
  }
}
