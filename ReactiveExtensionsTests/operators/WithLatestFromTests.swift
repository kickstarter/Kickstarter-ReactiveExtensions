import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions
@testable import ReactiveExtensions_TestHelpers

final class WithLatestFromTests: XCTestCase {

  func testSignal() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

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

  func testSignal_SamplerCompleting() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(2)

    test.assertValues([[2, 1]])

    sampleObserver.sendCompleted()

    test.assertDidComplete()
  }

  func testSignal_SourceCompleting() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(2)

    test.assertValues([[2, 1]])

    sourceObserver.sendCompleted()

    test.assertDidNotComplete()

    sampleObserver.sendNext(3)

    test.assertValues([[2, 1], [3, 1]])
  }

  func testSignal_SourceInterrupting() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testSignal_SampleInterrupting() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])
    
    sampleObserver.sendInterrupted()
    test.assertDidInterrupt()
  }
  
  func testProducer() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

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

  func testProducer_SamplerCompleting() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(2)

    test.assertValues([[2, 1]])

    sampleObserver.sendCompleted()

    test.assertDidComplete()
  }

  func testProducer_SourceCompleting() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(2)

    test.assertValues([[2, 1]])

    sourceObserver.sendCompleted()

    test.assertDidNotComplete()

    sampleObserver.sendNext(3)

    test.assertValues([[2, 1], [3, 1]])
  }

  func testProducer_SourceInterrupting() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])

    sourceObserver.sendInterrupted()
    test.assertDidInterrupt()
  }

  func testProducer_SampleInterrupting() {
    let (source, sourceObserver) = SignalProducer<Int, NoError>.buffer(0)
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let test = TestObserver<[Int], NoError>()
    sample.withLatestFrom(source).map { [$0, $1] }.observe(test.observer)

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    test.assertValues([[3, 1]])
    
    sampleObserver.sendInterrupted()
    test.assertDidInterrupt()
  }
}
