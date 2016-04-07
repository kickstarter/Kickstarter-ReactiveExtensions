import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class CombinePreviousTests: XCTestCase {

  func testCombinePrevious() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let combinePrevious = signal.combinePrevious()
    let test = TestObserver<[Int], NoError>()
    combinePrevious.map { [$0, $1] }.observe(test.observer)

    observer.sendNext(1)
    XCTAssertFalse(test.didEmitValue)

    observer.sendNext(2)
    test.assertValues([[1, 2]])

    observer.sendNext(3)
    test.assertValues([[1, 2], [2, 3]])

    observer.sendNext(4)
    test.assertValues([[1, 2], [2, 3], [3, 4]])
  }
}
