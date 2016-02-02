import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class CombinePreviousTests : XCTestCase {

  func testCombinePrevious() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let combinePrevious = signal.combinePrevious()
    let test = TestObserver<(Int, Int), NoError>()
    combinePrevious.observe(test.observer)
    
    observer.sendNext(1)
    XCTAssertFalse(test.didEmitValue)

    observer.sendNext(2)
    XCTAssert(test.nextValues == [(1, 2)])

    observer.sendNext(3)
    XCTAssert(test.nextValues == [(1, 2), (2, 3)])

    observer.sendNext(4)
    XCTAssert(test.nextValues == [(1, 2), (2, 3), (3, 4)])
  }
}
