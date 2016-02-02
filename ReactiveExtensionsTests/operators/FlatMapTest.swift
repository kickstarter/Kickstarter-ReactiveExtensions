import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

/// Returns `nil` for `x` even and `x` otherwise.
func nilOnEvens(x: Int) -> Int? {
  return x % 2 == 0 ? nil : x
}

final class FlatMapTest : XCTestCase {

  /// Flatmapping functions that return optionals should do the same as
  /// mapping and ignoring `nil`s.
  func testFlatMapOnNils() {
    let (signal, observer) = Signal<Int, NoError>.pipe()
    let flatMapped = signal.flatMap(nilOnEvens)
    let test = TestObserver<Int, NoError>()
    flatMapped.observe(test.observer)

    for x in 0..<10 {
      observer.sendNext(x)
    }

    XCTAssertEqual(test.nextValues, [1, 3, 5, 7, 9])
  }

  func testSignalProducerFlatMapOnNils() {
    let flatMapped = SignalProducer<Int, NoError>(values: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
      .flatMap(nilOnEvens)
    let test = TestObserver<Int, NoError>()
    flatMapped.start(test.observer)

    XCTAssertEqual(test.nextValues, [1, 3, 5, 7, 9])
  }
}
