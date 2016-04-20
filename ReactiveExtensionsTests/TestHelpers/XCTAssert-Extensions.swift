import XCTest
import ReactiveCocoa

// Assert equality between two doubly nested arrays of equatables.
internal func XCTAssertEqual<T: Equatable>(@autoclosure expression1: () -> [[T]],
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

// Assert equality between arrays of optionals of equatables.
internal func XCTAssertEqual <T: ReactiveCocoa.OptionalType where T.Wrapped: Equatable>
  (expression1: [T], _ expression2: [T], _ message: String = "",
   file: StaticString = #file, line: UInt = #line) {

  XCTAssertEqual(
    expression1.count, expression2.count,
    "Expected \(expression1.count) elements, but found \(expression2.count).",
    file: file, line: line
  )

  zip(expression1, expression2).forEach { xs, ys in
    XCTAssertEqual(
      xs.optional, ys.optional,
      "Expected \(expression1), but found \(expression2): \(message)",
      file: file, line: line
    )
  }
}
