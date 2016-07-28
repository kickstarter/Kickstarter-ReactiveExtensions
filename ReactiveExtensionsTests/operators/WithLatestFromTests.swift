import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class WithLatestFromTests: XCTestCase {

  func testWithLatestFromSignal() {
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

  func testWithLatestFromSignal_SourceCompleting() {
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

  func testWithLatestFromSignal_SourceErroring() {
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

  func testWithLatestFromSignal_SourceInterrupted() {
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

  func testWithLatestFromSignal_SampleErroring() {
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

  func testWithLatestFromSignal_SampleInterrupted() {
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

  func testWithLatestFromProducer() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    test.assertValues([])

    sourceProperty.value = 2
    test.assertValues([])

    sampleProperty.value = 3
    test.assertValues([[3, 2]])

    sampleProperty.value = 4
    test.assertValues([[3, 2], [4, 2]])

    sampleProperty.producer.startWithCompleted {
      test.assertDidNotComplete()
    }

    sourceProperty.producer.startWithCompleted {
      test.assertDidComplete()
    }
  }

  func testWithLatestFromProducer_SourceCompleting() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    sampleProperty.value = 3
    test.assertValues([[3, 1]])

    sourceProperty.producer.startWithCompleted {
      XCTAssert(test.didComplete)
    }
  }

  func testWithLatestFromProducer_SourceErroring() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    sampleProperty.value = 3
    test.assertValues([[3, 1]])

    sourceProperty.producer.startWithFailed { _ in
      XCTAssert(test.didFail)
    }
  }

  func testWithLatestFromProducer_SourceInterrupted() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    sampleProperty.value = 3
    test.assertValues([[3, 1]])

    sourceProperty.producer.startWithInterrupted {
      test.assertDidInterrupt()
    }
  }

  func testWithLatestFromProducer_SampleErroring() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    sampleProperty.value = 3
    test.assertValues([[3, 1]])

    sampleProperty.producer.startWithFailed { _ in
      test.assertDidNotFail()
    }
  }

  func testWithLatestFromProducer_SampleInterrupted() {
    let sourceProperty = MutableProperty<Int>(0)
    let sampleProperty = MutableProperty<Int>(0)
    let withLatestFrom = sampleProperty.signal.withLatestFrom(sourceProperty.producer)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceProperty.value = 1
    sampleProperty.value = 3
    test.assertValues([[3, 1]])

    sampleProperty.producer.startWithInterrupted {
      test.assertDidNotInterrupt()
    }
  }
}
