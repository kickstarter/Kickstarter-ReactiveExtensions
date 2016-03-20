import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class TakeWhenTests : XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], NoError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    test.assertValues([])

    sourceObserver.sendNext(2)
    test.assertValues([])

    sampleObserver.sendNext(3)
    test.assertValues([[2, 3]])

    sampleObserver.sendNext(4)
    test.assertValues([[2, 3], [2, 4]])

    sampleObserver.sendCompleted()
    XCTAssertFalse(test.didComplete)

    sourceObserver.sendCompleted()
    XCTAssertTrue(test.didComplete)
  }

  func testWithSourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], SomeError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[1, 3]])

    sourceObserver.sendCompleted()
    test.assertDidComplete()
  }

  func testWithSourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], SomeError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[1, 3]])

    sourceObserver.sendFailed(SomeError())
    test.assertDidFail()
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], NoError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[1, 3]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testWithSampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], SomeError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[1, 3]])

    sampleObserver.sendFailed(SomeError())
    test.assertDidNotFail()
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], NoError>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[1, 3]])

    sampleObserver.sendInterrupted()
    test.assertDidNotInterrupt()
  }

  func testTakeWhen() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takeWhen = source.takeWhen(sample)
    let test = TestObserver<Int, NoError>()
    takeWhen.observe(test.observer)

    sourceObserver.sendNext(1)
    test.assertValues([])

    sourceObserver.sendNext(2)
    test.assertValues([])

    sampleObserver.sendNext(3)
    test.assertValues([2])

    sourceObserver.sendNext(4)
    sampleObserver.sendNext(5)
    test.assertValues([2, 4])

    sampleObserver.sendCompleted()
    test.assertDidNotComplete()

    sourceObserver.sendCompleted()
    test.assertDidComplete()
  }
}
