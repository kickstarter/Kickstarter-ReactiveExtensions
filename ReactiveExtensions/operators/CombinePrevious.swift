import ReactiveCocoa

public extension SignalType {

  /**
   Returns a signal of pairs: the previously emitted value and the currently emitted value. The first
   emission is skipped, so non-optional `Value`s are returned.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func combinePrevious() -> Signal<(Value, Value), Error> {

    return self.signal
      .wrapInOptional()
      .combinePrevious(nil)
      .skip(1)
      .map { (old, new) in (old!, new!) }
  }
}

public extension SignalProducerType {

  /**
   Returns a producer of pairs: the previously emitted value and the currently emitted value. The first
   emission is skipped, so non-optional `Value`s are returned.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func combinePrevious() -> SignalProducer<(Value, Value), Error> {
    return lift { $0.combinePrevious() }
  }
}
