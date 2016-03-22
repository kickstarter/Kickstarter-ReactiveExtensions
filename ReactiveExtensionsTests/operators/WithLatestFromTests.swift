import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class WithLatestFromTests : XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    test.assertValues([])

    sourceObserver.sendNext(2)
    test.assertValues([])

    sampleObserver.sendNext(3)
    test.assertValues([[3, 2]])

    sampleObserver.sendNext(4)
    test.assertValues([[3, 2], [4, 2]])

    sampleObserver.sendCompleted()
    test.assertDidNotComplete()

    sourceObserver.sendCompleted()
    test.assertDidComplete()
  }

  func testWithSourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sourceObserver.sendFailed(SomeError())
    XCTAssert(test.didFail)
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testWithSampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sampleObserver.sendFailed(SomeError())
    test.assertDidNotFail()
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sampleObserver.sendInterrupted()
    test.assertDidNotInterrupt()
  }
}
