import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class EnumeratedTests: XCTestCase {

  func testEnumerated() {
    let (signal, observer) = Signal<String, NoError>.pipe()
    let testIdx = TestObserver<Int, NoError>()
    let testValue = TestObserver<String, NoError>()
    signal.enumerated().map { idx, _ in idx }.observe(testIdx.observer)
    signal.enumerated().map { _, value in value }.observe(testValue.observer)

    testIdx.assertValues([])
    testValue.assertValues([])

    observer.sendNext("hello")

    testIdx.assertValues([0])
    testValue.assertValues(["hello"])

    observer.sendNext("world")

    testIdx.assertValues([0, 1])
    testValue.assertValues(["hello", "world"])

    observer.sendNext("goodbye")

    testIdx.assertValues([0, 1, 2])
    testValue.assertValues(["hello", "world", "goodbye"])
  }
}
