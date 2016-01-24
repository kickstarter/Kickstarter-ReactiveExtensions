import ReactiveCocoa

public extension SignalType {

  /// Returns a signal of pairs containing the previously emitted value and the
  /// currently emitted value. Skips the first emission
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

  /// Returns a signal of pairs containing the previously emitted value and the
  /// currently emitted value. Skips the first emission.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func combinePrevious() -> SignalProducer<(Value, Value), Error> {
    return lift { $0.combinePrevious() }
  }
}
