import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class ScanTests: XCTestCase {

  func testScan() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let scan = signal.scan { $0 + $1 }
    let test = TestObserver<Int, NoError>()
    scan.observe(test.observer)

    observer.sendNext(1)
    observer.sendNext(2)
    observer.sendNext(3)
    observer.sendNext(4)

    test.assertValues([1, 3, 6, 10])

    observer.sendCompleted()

    test.assertDidComplete()
  }
}
