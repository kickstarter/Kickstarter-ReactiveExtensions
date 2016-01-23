import ReactiveCocoa

public extension SignalType {

  /// Merge `self` with `other` signal.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mergeWith (other: Signal<Value, Error>) -> Signal<Value, Error> {
    return Signal.merge([self.signal, other])
  }
}

public extension SignalProducerType {

  /// Merge `self` with `other` signal producer.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mergeWith (other: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
    return SignalProducer<SignalProducer<Value, Error>, Error>(values: [self.producer, other]).flatten(.Merge)
  }
}
