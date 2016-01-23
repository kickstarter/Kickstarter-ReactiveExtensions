import ReactiveCocoa

public extension SignalType {

  /// Turns a signal of `Value`s into a signal of `Optional<Value>`'s.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func wrapInOptional() -> Signal<Value?, Error> {
    return signal.map { x in Optional(x) }
  }
}

public extension SignalProducerType {

  /// Turns a signal of `Value`s into a signal of `Optional<Value>`'s.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func wrapInOptional() -> SignalProducer<Value?, Error> {
    return lift { $0.wrapInOptional() }
  }
}
