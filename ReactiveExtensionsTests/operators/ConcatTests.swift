import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class ConcatTests: XCTestCase {

  func testConcat() {
    let (s1, o1) = Signal<Int, NoError>.pipe()
    let (s2, o2) = Signal<Int, NoError>.pipe()
    let concat = Signal.concat(s1, s2)

    let test = TestObserver<Int, NoError>()
    concat.observe(test.observer)

    o1.sendNext(1)
    o1.sendNext(2)
    o1.sendCompleted()
    o2.sendNext(3)
    o2.sendNext(4)
    o2.sendCompleted()

    test.assertValues([1, 2, 3, 4])
  }
}
