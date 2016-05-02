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

    sourceObserver.sendCompleted()
    test.assertDidNotComplete()

    sampleObserver.sendCompleted()
    test.assertDidComplete()
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
    test.assertDidInterrupt()
  }

  func testWithLatestFromProducer() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
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

    sourceObserver.sendCompleted()
    test.assertDidNotComplete()

    sampleObserver.sendCompleted()
    test.assertDidComplete()
  }

  func testWithLatestFromProducer_SourceInterrupted() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
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

  func testWithLatestFromProducer_SampleInterrupted() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let withLatestFrom = sample.withLatestFrom(source)
    let test = TestObserver<[Int], NoError>()
    withLatestFrom.map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sampleObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

}
