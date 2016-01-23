import ReactiveCocoa

public extension SignalType {

  /// Converts a signal of any type to a signal of void values.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func ignoreValues() -> Signal<Void, Error> {
    return signal.map { _ in () }
  }
}

public extension SignalProducerType {

  /// Converts a signal of any type to a signal of void values.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func ignoreValues() -> SignalProducer<Void, Error> {
    return lift { $0.ignoreValues() }
  }
}
