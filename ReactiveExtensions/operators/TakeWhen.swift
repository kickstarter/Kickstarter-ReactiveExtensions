import ReactiveCocoa

public extension SignalType {

  /// Emits the latest value of `self` when `other` emits.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takeWhen <U> (other: Signal<U, Error>) -> Signal<Value, Error> {
    return other.withLatestFrom(self.signal).map { tuple in tuple.1 }
  }

  /// Emits the latest value of `self` when `other` emits.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takePairWhen <U> (other: Signal<U, Error>) -> Signal<(Value, U), Error> {
    return other.withLatestFrom(self.signal).map { ($0.1, $0.0) }
  }
}

public extension SignalProducerType {

  /// Emits the latest value of `self` when `other` emits.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takeWhen <U> (other: SignalProducer<U, Error>) -> SignalProducer<Value, Error> {
    return lift(Signal.takeWhen)(other)
  }

  /// Emits the latest value of `self` when `other` emits.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takeWhen <U> (other: Signal<U, Error>) -> SignalProducer<Value, Error> {
    return lift { $0.takeWhen(other) }
  }
}
