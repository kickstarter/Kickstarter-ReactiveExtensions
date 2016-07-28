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
    let property1 = MutableProperty<Int>(0)
    let property2 = MutableProperty<Int>(0)

    let concat = SignalProducer.concat(property1.producer.skip(1), property2.producer.skip(1))

    let test = TestObserver<Int, NoError>()
    concat.start(test.observer)

    property1.value = 1
    property1.value = 2
    property1.producer.startWithCompleted {
      property2.value = 3
      property2.value = 4
    }
    property2.producer.startWithCompleted {
      test.assertValues([1, 2, 3, 4])
    }
  }
}
