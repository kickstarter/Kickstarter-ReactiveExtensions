import ReactiveCocoa

public extension SignalProducerType {

  /// Returns a new producer that begins with a specific `value`
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func beginsWith (value value: Value) -> SignalProducer<Value, Error> {
    return SignalProducer<Value, Error>(value: value).mergeWith(self.producer)
  }

  /// Returns a new producer that begins with the specificed `values`
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func beginsWith (values values: [Value]) -> SignalProducer<Value, Error> {
    return SignalProducer<Value, Error>(values: values).mergeWith(self.producer)
  }
}
