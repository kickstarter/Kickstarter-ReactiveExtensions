import XCTest
import ReactiveCocoa

internal func XCTAssertEqual <A> (
  @autoclosure expression1: () -> A,
               _ equality: (A, A) -> Bool,
               @autoclosure _ expression2: () -> A,
                            _ message: String = "",
                              file: StaticString = #file,
                              line: UInt = #line) {

  let lhs = expression1()
  let rhs = expression2()

  XCTAssertTrue(equality(lhs, rhs),
                "Expected \(lhs), but found \(rhs): \(message)",
                file: file,
                line: line)
}

internal func XCTAssertEqual <A> (
  @autoclosure expression1: () -> [A],
               _ equality: (A, A) -> Bool,
               @autoclosure _ expression2: () -> [A],
                            _ message: String = "",
                              file: StaticString = #file,
                              line: UInt = #line) {

  let lhs = expression1()
  let rhs = expression2()

  XCTAssertEqual(lhs.count, rhs.count,
                 "Expected \(lhs.count) elements, but found \(rhs.count).",
                 file: file,
                 line: line)

  zip(lhs, rhs).forEach { x, y in
    XCTAssertEqual(
      x, equality, y,
      "Expected \(lhs), but found \(rhs): \(message)",
      file: file,
      line: line
    )
  }
}
