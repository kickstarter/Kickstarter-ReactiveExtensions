import XCTest

// Assert equality between two doubly nested arrays of equatables.
internal func XCTAssertEqual<T : Equatable>(@autoclosure expression1: () -> [[T]],
  @autoclosure _ expression2: () -> [[T]], _ message: String = "",
                 file: StaticString = #file, line: UInt = #line) {

    let lhs = expression1()
    let rhs = expression2()
    XCTAssertEqual(lhs.count, rhs.count, "Expected \(lhs.count) elements, but found \(rhs.count).",
      file: file, line: line)

    zip(lhs, rhs).forEach { xs, ys in
      XCTAssertEqual(xs, ys, "Expected \(lhs), but found \(rhs): \(message)", file: file, line: line)
    }
}
