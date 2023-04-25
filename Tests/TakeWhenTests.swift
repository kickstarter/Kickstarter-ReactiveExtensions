import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class TakeWhenTests: XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], Never>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    test.assertValues([])

    sourceObserver.send(value: 2)
    test.assertValues([])

    sampleObserver.send(value: 3)
    test.assertValues([[2, 3]])

    sampleObserver.send(value: 4)
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

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
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

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[1, 3]])

    sourceObserver.send(error: SomeError())
    test.assertDidFail()
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], Never>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
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

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[1, 3]])

    sampleObserver.send(error: SomeError())
    test.assertDidNotFail()
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let takePairWhen = source.takePairWhen(sample)
    let test = TestObserver<[Int], Never>()
    takePairWhen.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[1, 3]])

    sampleObserver.sendInterrupted()
    test.assertDidNotInterrupt()
  }

  func testTakeWhen() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let takeWhen = source.takeWhen(sample)
    let test = TestObserver<Int, Never>()
    takeWhen.observe(test.observer)

    sourceObserver.send(value: 1)
    test.assertValues([])

    sourceObserver.send(value: 2)
    test.assertValues([])

    sampleObserver.send(value: 3)
    test.assertValues([2])

    sourceObserver.send(value: 4)
    sampleObserver.send(value: 5)
    test.assertValues([2, 4])

    sampleObserver.sendCompleted()
    test.assertDidNotComplete()

    sourceObserver.sendCompleted()
    test.assertDidComplete()
  }
}
