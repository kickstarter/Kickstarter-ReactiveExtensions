import ReactiveCocoa

public extension SignalType {
  public func allValues() -> [Value] {
    var values: [Value] = []
    self.signal.observeNext { values.append($0) }
    return values
  }
}

extension SignalProducerType {
  public func allValues() -> [Value] {
    var values: [Value] = []
    self.producer.startWithNext { values.append($0) }
    return values
  }
}
