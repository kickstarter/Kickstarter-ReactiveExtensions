import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class ConcatTests: XCTestCase {

  func testSignal_Concat() {
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

  func testProducer_Concat() {
    let (p1, o1) = SignalProducer<Int, NoError>.buffer(0)
    let (p2, o2) = SignalProducer<Int, NoError>.buffer(0)
    let concat = SignalProducer.concat(p1, p2)

    let test = TestObserver<Int, NoError>()
    concat.start(test.observer)

    o1.sendNext(1)
    o1.sendNext(2)
    o1.sendCompleted()
    o2.sendNext(3)
    o2.sendNext(4)
    o2.sendCompleted()

    test.assertValues([1, 2, 3, 4])
  }
}
