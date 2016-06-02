import ReactiveCocoa

public extension SignalProducerType {

  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  /**
   Make a producer begin with a specific value.

   - parameter value: A value.

   - returns: A new producer that immediately emits a specific value when it is started.
   */
  @available(*, deprecated=1.0, message="Use prefix() instead")
  public func beginsWith (value value: Value) -> SignalProducer<Value, Error> {
    return SignalProducer.merge(
      SignalProducer<Value, Error>(value: value),
      self.producer
    )
  }

  /**
   Make a producer begin with a specific array of values.

   - parameter values: An array of values.

   - returns: A new producer that immediately emits all the values in `values`.
   */
  @available(*, deprecated=1.0, message="Use prefix() instead")
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func beginsWith (values values: [Value]) -> SignalProducer<Value, Error> {
    return SignalProducer.merge(
      SignalProducer<Value, Error>(values: values),
      self.producer
    )
  }
}
