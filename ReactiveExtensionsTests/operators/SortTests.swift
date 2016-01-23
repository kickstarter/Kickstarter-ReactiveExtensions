import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class SortTests : XCTestCase {

  func testSignalSort() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let sort = signal.sort()
    let sortTest = sort.testObserve()

    observer.sendNext([2, 1, 3])
    observer.sendNext([3, 2, 1])
    observer.sendNext([1, 2, 3])

    XCTAssertEqual(sortTest.nextValues, [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  }

  func testSignalSortWithComparator() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let sort = signal.sort(>)
    let sortTest = sort.testObserve()

    observer.sendNext([2, 1, 3])
    observer.sendNext([3, 2, 1])
    observer.sendNext([1, 2, 3])

    XCTAssertEqual(sortTest.nextValues, [[3, 2, 1], [3, 2, 1], [3, 2, 1]])
  }

  func testSignalProducerSort() {
    let producer = SignalProducer<[Int], NoError>(values: [[2, 1, 3], [3, 2, 1], [1, 2, 3]])
    let sort = producer.sort()

    XCTAssertEqual(sort.allValues(), [[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  }

  func testSignalProducerSortWithComparator() {
    let producer = SignalProducer<[Int], NoError>(values: [[2, 1, 3], [3, 2, 1], [1, 2, 3]])
    let sort = producer.sort(>)

    XCTAssertEqual(sort.allValues(), [[3, 2, 1], [3, 2, 1], [3, 2, 1]])
  }
}
