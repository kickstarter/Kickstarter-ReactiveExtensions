import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class TakeUntilTests: XCTestCase {

  func testStandard() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let takeUntil = signal.takeUntil { $0 % 2 == 0 }
    let test = TestObserver<Int, NoError>()
    takeUntil.observe(test.observer)

    observer.sendNext(1)
    observer.sendNext(3)
    observer.sendNext(5)
    observer.sendNext(2)

    test.assertValues([1, 3, 5, 2])
    test.assertDidComplete()
  }
}
