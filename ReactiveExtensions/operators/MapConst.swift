import ReactiveCocoa

public extension SignalType {

  /// Map a signal to a constant
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mapConst <U> (value: U) -> Signal<U, Error> {
    return self.signal.map { _ in value }
  }
}

public extension SignalProducerType {

  /// Map a producer to a constant
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mapConst <U> (value: U) -> SignalProducer<U, Error> {
    return lift { $0.mapConst(value) }
  }
}
