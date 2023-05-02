import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class TakeUntilTests: XCTestCase {

  func testStandard() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let takeUntil = signal.takeUntil { $0 % 2 == 0 }
    let test = TestObserver<Int, Never>()
    takeUntil.observe(test.observer)

    observer.send(value: 1)
    observer.send(value: 3)
    observer.send(value: 5)
    observer.send(value: 2)

    test.assertValues([1, 3, 5, 2])
    test.assertDidComplete()
  }
}
