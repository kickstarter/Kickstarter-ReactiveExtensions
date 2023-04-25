import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class ConcatTests: XCTestCase {

  func testSignal_Concat() {
    let (s1, o1) = Signal<Int, Never>.pipe()
    let (s2, o2) = Signal<Int, Never>.pipe()
    let concat = Signal.concat(s1, s2)

    let test = TestObserver<Int, Never>()
    concat.observe(test.observer)

    o1.send(value: 1)
    o1.send(value: 2)
    o1.sendCompleted()
    o2.send(value: 3)
    o2.send(value: 4)
    o2.sendCompleted()

    test.assertValues([1, 2, 3, 4])
  }

  func testProducer_Concat() {
    let (s1, o1) = Signal<Int, Never>.pipe()
    let (s2, o2) = Signal<Int, Never>.pipe()
    let p1 = SignalProducer(s1)
    let p2 = SignalProducer(s2)

    let concat = SignalProducer.concat(p1, p2)

    let test = TestObserver<Int, Never>()
    concat.start(test.observer)

    o1.send(value: 1)
    o1.send(value: 2)
    o1.sendCompleted()
    o2.send(value: 3)
    o2.send(value: 4)
    o2.sendCompleted()

    test.assertValues([1, 2, 3, 4])
  }
}
