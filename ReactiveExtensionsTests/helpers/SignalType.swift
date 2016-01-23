import ReactiveCocoa

internal extension SignalType {
  internal func testObserve() -> SignalTester<Value, Error> {
    let tester = SignalTester<Value, Error>()
    self.observe { event in tester.events.append(event) }
    return tester
  }
}
