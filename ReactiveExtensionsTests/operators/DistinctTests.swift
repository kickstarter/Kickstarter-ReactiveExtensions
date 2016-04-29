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
    o.sendNext(2)
    o.sendNext(1)
    o.sendNext(3)
    o.sendNext(2)
    o.sendNext(4)
    o.sendNext(3)
    o.sendNext(5)
    o.sendCompleted()

    test.assertValues([1, 2, 3, 4, 5])
    test.assertDidComplete()
  }

  func testSignalDistinctsFailed() {
    let (s, o) = Signal<Int, SomeError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, SomeError>()
    distincts.observe(test.observer)

    o.sendNext(1)
    o.sendNext(2)
    o.sendNext(1)
    o.sendNext(3)
    o.sendNext(2)
    o.sendNext(4)
    o.sendNext(3)
    o.sendNext(5)
    o.sendFailed(SomeError())

    test.assertValues([1, 2, 3, 4, 5])
    test.assertFailed(SomeError())
  }

  func testSignalDistinctsInterrupted() {
    let (s, o) = Signal<Int, NoError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.observe(test.observer)

    o.sendNext(1)
    o.sendNext(2)
    o.sendNext(1)
    o.sendNext(3)
    o.sendNext(2)
    o.sendNext(4)
    o.sendNext(3)
    o.sendNext(5)
    o.sendInterrupted()

    test.assertValues([1, 2, 3, 4, 5])
    test.assertDidInterrupt()
  }

  func testSignalDistinctsWithKeySelector() {
    let (s, o) = Signal<Int, NoError>.pipe()
    let distincts = s.distincts { String($0) }

    let test = TestObserver<Int, NoError>()
    distincts.observe(test.observer)

    o.sendNext(1)
    o.sendNext(2)
    o.sendNext(1)
    o.sendNext(3)
    o.sendNext(2)
    o.sendNext(4)
    o.sendNext(3)
    o.sendNext(5)
    o.sendCompleted()

    test.assertValues([1, 2, 3, 4, 5])
    test.assertDidComplete()
  }
}
