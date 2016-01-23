import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class StartAndShareTest : XCTestCase {

  func testStartAndShare() {
    // A producer that has a side effect so we can track how many times it was executed.
    var sideEffect = 0
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .on(started: { sideEffect++ })

    let sharedProducer = producer.startAndShare()

    // Fire off the shared producer multiple times
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }

    // We should only observe the side affect once
    XCTAssertEqual(sideEffect, 1)

    // With no `replayCount` specified we should miss out on the initial values.
    XCTAssertEqual(sharedProducer.allValues(), [])
  }

  func testStartAndShareWithReply() {
    // A producer that has a side effect so we can track how many times it was executed.
    var sideEffect = 0
    let producer = SignalProducer<Int, NoError>(values: [1, 2, 3, 4])
      .on(started: { sideEffect++ })

    let sharedProducer = producer.startAndShare(replayCount: 4)

    // Fire off the shared producer multiple times
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }
    sharedProducer.startWithNext { _ in return }

    // We should only observe the side affect once
    XCTAssertEqual(sideEffect, 1)

    // With `replayCount` specified we should get the initial values emitted.
    XCTAssertEqual(sharedProducer.allValues(), [1, 2, 3, 4])
  }
}
