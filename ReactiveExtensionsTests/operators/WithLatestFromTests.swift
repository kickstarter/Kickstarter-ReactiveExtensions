import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class WithLatestFromTests : XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    XCTAssertEqual(test.nextValues, [])

    sourceObserver.sendNext(2)
    XCTAssertEqual(test.nextValues, [])

    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 2]])

    sampleObserver.sendNext(4)
    XCTAssertEqual(test.nextValues, [[3, 2], [4, 2]])

    sampleObserver.sendCompleted()
    XCTAssert(!test.didComplete)

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 1]])

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 1]])

    sourceObserver.sendFailed(SomeError())
    XCTAssert(test.didFail)
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 1]])

    sourceObserver.sendInterrupted()
    XCTAssert(test.didInterrupt)
  }

  func testWithSampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 1]])

    sampleObserver.sendFailed(SomeError())
    XCTAssert(!test.didFail)
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source).map { [$0.0, $0.1] }
    let test = withLatestFrom.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[3, 1]])

    sampleObserver.sendInterrupted()
    XCTAssert(!test.didInterrupt)
  }
}
