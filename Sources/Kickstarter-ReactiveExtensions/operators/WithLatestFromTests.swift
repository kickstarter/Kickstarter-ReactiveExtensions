import XCTest
import ReactiveSwift
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class WithLatestFromTests: XCTestCase {

  func testWithLatestFromSignal() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    test.assertValues([])

    sourceObserver.send(value: 2)
    test.assertValues([])

    sampleObserver.send(value: 3)
    test.assertValues([[3, 2]])

    sampleObserver.send(value: 4)
    test.assertValues([[3, 2], [4, 2]])

    sampleObserver.sendCompleted()
    test.assertDidNotComplete()

    sourceObserver.sendCompleted()
    test.assertDidComplete()
  }

  func testWithLatestFromSignal_SourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithLatestFromSignal_SourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.send(error: SomeError())
    XCTAssert(test.didFail)
  }

  func testWithLatestFromSignal_SourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testWithLatestFromSignal_SampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sampleObserver.send(error: SomeError())
    test.assertDidNotFail()
  }

  func testWithLatestFromSignal_SampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sampleObserver.sendInterrupted()
    test.assertDidNotInterrupt()
  }

  func testWithLatestFromProducer() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    test.assertValues([])

    sourceObserver.send(value: 2)
    test.assertValues([])

    sampleObserver.send(value: 3)
    test.assertValues([[3, 2]])

    sampleObserver.send(value: 4)
    test.assertValues([[3, 2], [4, 2]])

    sampleObserver.sendCompleted()

    test.assertDidNotComplete()

    sourceObserver.sendCompleted()

    test.assertDidComplete()
  }

  func testWithLatestFromProducer_SourceCompleting() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.sendCompleted()

    XCTAssert(test.didComplete)
  }

  func testWithLatestFromProducer_SourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.send(error: SomeError())
    XCTAssert(test.didFail)
  }

  func testWithLatestFromProducer_SourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testWithLatestFromProducer_SampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], SomeError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sampleObserver.send(error: SomeError())

    test.assertDidNotFail()
  }

  func testWithLatestFromProducer_SampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, Never>.pipe()
    let (sample, sampleObserver) = Signal<Int, Never>.pipe()
    let sourceProducer = SignalProducer(source)
    let withLatestFrom = sample.withLatestFrom(sourceProducer)
    let test = TestObserver<[Int], Never>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.send(value: 1)
    sampleObserver.send(value: 3)
    test.assertValues([[3, 1]])

    sampleObserver.sendInterrupted()

    test.assertDidNotInterrupt()
  }
}
