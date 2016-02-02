import XCTest
import ReactiveCocoa
import Result
@testable import ReactiveExtensions

final class StartAndShareTest : XCTestCase {

  func testStartAndShare() {
    // A producer that has a side effect so we can track how many times it was executed.
    var sideEffect = 0
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .on(started: { sideEffect++ })

    let sharedProducer = producer.startAndShare()
    let test = TestObserver<Int, NoError>()
    sharedProducer.start(test.observer)

    // Fire off the shared producer multiple times
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }

    // We should only observe the side affect once
    XCTAssertEqual(sideEffect, 1)

    // With no `replayCount` specified we should miss out on the initial values.
    XCTAssertEqual(test.nextValues, [])
  }

  func testStartAndShareWithReply() {
    // A producer that has a side effect so we can track how many times it was executed.
    var sideEffect = 0
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .on(started: { sideEffect++ })

    let sharedProducer = producer.startAndShare(replayCount: 4)
    let test = TestObserver<Int, NoError>()
    sharedProducer.start(test.observer)

    // Fire off the shared producer multiple times
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }

    // We should only observe the side affect once
    XCTAssertEqual(sideEffect, 1)

    // With `replayCount` specified we should get the initial values emitted.
    XCTAssertEqual(test.nextValues, [1, 2, 3, 4])
  }
}
