import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class ScanTests: XCTestCase {

  func testScan() {
    let (signal, observer) = Signal<Int, Never>.pipe()
    let scan = signal.scan { $0 + $1 }
    let test = TestObserver<Int, Never>()
    scan.observe(test.observer)

    observer.send(value: 1)
    observer.send(value: 2)
    observer.send(value: 3)
    observer.send(value: 4)

    test.assertValues([1, 3, 6, 10])

    observer.sendCompleted()

    test.assertDidComplete()
  }
}
