import XCTest

extension XCTestCase {
  internal func async(expect description: String = "async",
                      timeout: Double = 5,
                      block: @escaping (() -> Void) -> Void) {
    let expectation = self.expectation(description: description)
    DispatchQueue.main.async {
      block(expectation.fulfill)
    }
    waitForExpectations(timeout: timeout, handler: nil)
  }

  internal func eventually( _ assertion: @autoclosure @escaping () -> Void) {
    async { done in
      assertion()
      done()
    }
  }
}
