import XCTest
import ReactiveSwift
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class SortTests: XCTestCase {

  func testSignalSort() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let sort = signal.sort()
    let test = TestObserver<[Int], NoError>()
    sort.observe(test.observer)

    observer.send(value: [2, 1, 3])
    observer.send(value: [3, 2, 1])
    observer.send(value: [1, 2, 3])

    test.assertValues([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  }

  func testSignalSortWithComparator() {
    let (signal, observer) = Signal<[Int], NoError>.pipe()
    let sort = signal.sort(>)
    let test = TestObserver<[Int], NoError>()
    sort.observe(test.observer)

    observer.send(value: [2, 1, 3])
    observer.send(value: [3, 2, 1])
    observer.send(value: [1, 2, 3])

    test.assertValues([[3, 2, 1], [3, 2, 1], [3, 2, 1]])
  }

  func testSignalProducerSort() {
    let producer = SignalProducer<[Int], NoError>([[2, 1, 3], [3, 2, 1], [1, 2, 3]])
    let sort = producer.sort()
    let test = TestObserver<[Int], NoError>()
    sort.start(test.observer)

    test.assertValues([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
  }

  func testSignalProducerSortWithComparator() {
    let producer = SignalProducer<[Int], NoError>([[2, 1, 3], [3, 2, 1], [1, 2, 3]])
    let sort = producer.sort(>)
    let test = TestObserver<[Int], NoError>()
    sort.start(test.observer)

    test.assertValues([[3, 2, 1], [3, 2, 1], [3, 2, 1]])
  }
}
