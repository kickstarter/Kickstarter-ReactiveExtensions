import ReactiveCocoa

extension SignalProducerType {
  public func allValues() -> [Value] {
    return self.producer
      .demoteErrors()
      .collect()
      .single()!
      .value!
  }
}
