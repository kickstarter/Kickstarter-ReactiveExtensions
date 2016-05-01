import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class DistinctTests: XCTestCase {

  func testSignalDistincts() {
    let (s, o) = Signal<Int, NoError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.observe(test.observer)

    o.sendNext(1)
    test.assertValues([1])

    o.sendNext(2)
    test.assertValues([1, 2])

    o.sendNext(1)
    test.assertValues([1, 2])

    o.sendNext(3)
    test.assertValues([1, 2, 3])

    o.sendNext(2)
    test.assertValues([1, 2, 3])

    o.sendNext(4)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(3)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(5)
    test.assertValues([1, 2, 3, 4, 5])

    o.sendCompleted()
    test.assertDidComplete()
  }

  func testSignalDistinctsFailed() {
    let (s, o) = Signal<Int, SomeError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, SomeError>()
    distincts.observe(test.observer)

    o.sendFailed(SomeError())
    test.assertFailed(SomeError())
  }

  func testSignalDistinctsInterrupted() {
    let (s, o) = Signal<Int, NoError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.observe(test.observer)

    o.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testSignalDistinctsWithKeySelector() {
    let (s, o) = Signal<Int, NoError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.observe(test.observer)

    o.sendNext(1)
    test.assertValues([1])

    o.sendNext(2)
    test.assertValues([1, 2])

    o.sendNext(1)
    test.assertValues([1, 2])

    o.sendNext(3)
    test.assertValues([1, 2, 3])

    o.sendNext(2)
    test.assertValues([1, 2, 3])

    o.sendNext(4)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(3)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(5)
    test.assertValues([1, 2, 3, 4, 5])

    o.sendCompleted()
    test.assertDidComplete()
  }

  func testProducerDistincts() {
    let (s, o) = SignalProducer<Int, NoError>.buffer(0)
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.start(test.observer)

    o.sendNext(1)
    test.assertValues([1])

    o.sendNext(2)
    test.assertValues([1, 2])

    o.sendNext(1)
    test.assertValues([1, 2])

    o.sendNext(3)
    test.assertValues([1, 2, 3])

    o.sendNext(2)
    test.assertValues([1, 2, 3])

    o.sendNext(4)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(3)
    test.assertValues([1, 2, 3, 4])

    o.sendNext(5)
    test.assertValues([1, 2, 3, 4, 5])

    o.sendCompleted()
    test.assertDidComplete()
  }
}
