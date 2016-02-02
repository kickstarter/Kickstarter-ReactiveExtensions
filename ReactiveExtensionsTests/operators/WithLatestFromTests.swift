import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class WithLatestFromTests : XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), NoError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    XCTAssert(test.nextValues == [])

    sourceObserver.sendNext(2)
    XCTAssert(test.nextValues == [])

    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 2)])

    sampleObserver.sendNext(4)
    XCTAssert(test.nextValues == [(3, 2), (4, 2)])

    sampleObserver.sendCompleted()
    XCTAssertFalse(test.didComplete)

    sourceObserver.sendCompleted()
    XCTAssertTrue(test.didComplete)
  }

  func testWithSourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), SomeError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 1)])

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), SomeError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 1)])

    sourceObserver.sendFailed(SomeError())
    XCTAssert(test.didFail)
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), NoError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 1)])

    sourceObserver.sendInterrupted()
    XCTAssertTrue(test.didInterrupt)
  }

  func testWithSampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), SomeError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 1)])

    sampleObserver.sendFailed(SomeError())
    XCTAssertFalse(test.didFail)
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<(Int, Int), NoError>()
    withLatestFrom.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssert(test.nextValues == [(3, 1)])

    sampleObserver.sendInterrupted()
    XCTAssertFalse(test.didInterrupt)
  }
}
