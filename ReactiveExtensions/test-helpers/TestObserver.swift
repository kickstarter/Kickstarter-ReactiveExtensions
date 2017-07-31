import XCTest
import ReactiveSwift

/**
 A `TestObserver` is a wrapper around an `Observer` that saves all events to an internal array so that
 assertions can be made on a signal's behavior. To use, just create an instance of `TestObserver` that
 matches the type of signal/producer you are testing, and observer/start your signal by feeding it the
 wrapped observer. For example,

 ```
 let test = TestObserver<Int, NoError>()
 mySignal.observer(test.observer)

 // ... later ...

 test.assertValues([1, 2, 3])
 ```
 */
internal final class TestObserver <Value, Error: Swift.Error> {

  internal private(set) var events: [Event<Value, Error>] = []
  internal private(set) var observer: Observer<Value, Error>!

  internal init() {
    self.observer = Observer<Value, Error>(action)
  }

  private func action(_ event: Event<Value, Error>) {
    self.events.append(event)
  }

  /// Get all of the next values emitted by the signal.
  internal var values: [Value] {
    return self.events.filter { $0.isValue }.map { $0.value! }
  }

  /// Get the last value emitted by the signal.
  internal var lastValue: Value? {
    return self.values.last
  }

  /// `true` if at least one `.Next` value has been emitted.
  internal var didEmitValue: Bool {
    return self.values.count > 0
  }

  /// The failed error if the signal has failed.
  internal var failedError: Error? {
    return self.events.filter { $0.isFailed }.map { $0.error! }.first
  }

  /// `true` if a `.Failed` event has been emitted.
  internal var didFail: Bool {
    return self.failedError != nil
  }

  /// `true` if a `.Completed` event has been emitted.
  internal var didComplete: Bool {
    return self.events.filter { $0.isCompleted }.count > 0
  }

  /// `true` if a .Interrupt` event has been emitted.
  internal var didInterrupt: Bool {
    return self.events.filter { $0.isInterrupted }.count > 0
  }

  internal func assertDidComplete(_ message: String = "Should have completed.",
                                  file: StaticString = #file, line: UInt = #line) {
      XCTAssertTrue(self.didComplete, message, file: file, line: line)
  }

  internal func assertDidFail(_ message: String = "Should have failed.",
                              file: StaticString = #file, line: UInt = #line) {
      XCTAssertTrue(self.didFail, message, file: file, line: line)
  }

  internal func assertDidNotFail(_ message: String = "Should not have failed.",
                                 file: StaticString = #file, line: UInt = #line) {
      XCTAssertFalse(self.didFail, message, file: file, line: line)
  }

  internal func assertDidInterrupt(_ message: String = "Should have failed.",
                                   file: StaticString = #file, line: UInt = #line) {
      XCTAssertTrue(self.didInterrupt, message, file: file, line: line)
  }

  internal func assertDidNotInterrupt(_ message: String = "Should not have failed.",
                                      file: StaticString = #file, line: UInt = #line) {
      XCTAssertFalse(self.didInterrupt, message, file: file, line: line)
  }

  internal func assertDidNotComplete(_ message: String = "Should not have completed",
                                     file: StaticString = #file, line: UInt = #line) {
      XCTAssertFalse(self.didComplete, message, file: file, line: line)
  }

  internal func assertDidEmitValue(_ message: String = "Should have emitted at least one value.",
                                   file: StaticString = #file, line: UInt = #line) {
      XCTAssert(self.values.count > 0, message, file: file, line: line)
  }

  internal func assertDidNotEmitValue(_ message: String = "Should not have emitted any values.",
                                      file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(0, self.values.count, message, file: file, line: line)
  }

  internal func assertDidTerminate(
    _ message: String = "Should have terminated, i.e. completed/failed/interrupted.",
    file: StaticString = #file, line: UInt = #line) {
      XCTAssertTrue(self.didFail || self.didComplete || self.didInterrupt, message, file: file, line: line)
  }

  internal func assertDidNotTerminate(
    _ message: String = "Should not have terminated, i.e. completed/failed/interrupted.",
    file: StaticString = #file, line: UInt = #line) {
      XCTAssertTrue(!self.didFail && !self.didComplete && !self.didInterrupt, message, file: file, line: line)
  }

  internal func assertValueCount(_ count: Int, _ message: String? = nil,
                                 file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(count, self.values.count, message ?? "Should have emitted \(count) values",
        file: file, line: line)
  }
}

extension TestObserver where Value: Equatable {
  internal func assertValue(_ value: Value, _ message: String? = nil,
                            file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(1, self.values.count, "A single item should have been emitted.", file: file, line: line)
    XCTAssertEqual(value, self.lastValue, message ?? "A single value of \(value) should have been emitted",
                   file: file, line: line)
  }

  internal func assertLastValue(_ value: Value, _ message: String? = nil,
                                file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(value, self.lastValue, message ?? "Last emitted value is equal to \(value).",
                   file: file, line: line)
  }

  internal func assertValues(_ values: [Value], _ message: String = "",
                             file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(values, self.values, message, file: file, line: line)
  }
}

extension TestObserver where Value: ReactiveSwift.OptionalProtocol, Value.Wrapped: Equatable {

  internal func assertValue(_ value: Value, _ message: String? = nil,
                            file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(1, self.values.count, "A single item should have been emitted.", file: file, line: line)
    XCTAssertEqual(value.optional, self.lastValue?.optional,
                   message ?? "A single value of \(value) should have been emitted",
                   file: file, line: line)
  }

  internal func assertLastValue(_ value: Value, _ message: String? = nil,
                                file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(value.optional, self.lastValue?.optional,
                   message ?? "Last emitted value is equal to \(value).",
                   file: file, line: line)
  }

  internal func assertValues(_ values: [Value], _ message: String = "",
                             file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(values, self.values, message, file: file, line: line)
  }
}

extension TestObserver where Value: Sequence, Value.Iterator.Element: Equatable {

  internal func assertValue(_ value: Value, _ message: String? = nil,
                            file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(1, self.values.count, "A single item should have been emitted.", file: file, line: line)
    XCTAssertEqual(Array(value), self.lastValue.map(Array.init) ?? [],
                   message ?? "A single value of \(value) should have been emitted",
                   file: file, line: line)
  }

  internal func assertLastValue(_ value: Value, _ message: String? = nil,
                                file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(Array(value), self.lastValue.map(Array.init) ?? [],
                   message ?? "Last emitted value is equal to \(value).",
                   file: file, line: line)
  }

  internal func assertValues(_ values: [[Value.Iterator.Element]], _ message: String = "",
                             file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(Array(values), Array(self.values.map(Array.init)), message, file: file, line: line)
  }
}

extension TestObserver where Error: Equatable {
  internal func assertFailed(_ expectedError: Error, message: String = "",
                             file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(expectedError, self.failedError, message, file: file, line: line)
  }
}
