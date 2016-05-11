import XCTest

extension XCTestCase {
  internal func async(expect description: String = "async",
                             timeout: Double = 5,
                             block: (() -> Void) -> Void) {
    let expectation = expectationWithDescription(description)
    dispatch_async(dispatch_get_main_queue()) {
      block(expectation.fulfill)
    }
    waitForExpectationsWithTimeout(timeout, handler: nil)
  }

  internal func eventually(@autoclosure(escaping) assertion: () -> Void) {
    async { done in
      assertion()
      done()
    }
  }
}
