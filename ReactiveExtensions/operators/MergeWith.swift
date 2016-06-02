import ReactiveCocoa

public extension SignalType {

  /**
   Merges `self` with another signal.

   - parameter other: The other signal.

   - returns: A merged signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mergeWith (other: Signal<Value, Error>) -> Signal<Value, Error> {
    return Signal.merge([self.signal, other])
  }
}

public extension SignalProducerType {

  /**
   Merges `self` with another producer.

   - parameter other: The other producer.

   - returns: A merged producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mergeWith (other: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
    return SignalProducer<SignalProducer<Value, Error>, Error>(values: [self.producer, other]).flatten(.Merge)
  }
}
