import ReactiveCocoa

public extension SignalType {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takeWhen <U> (other: Signal<U, Error>) -> Signal<Value, Error> {
    return other.withLatestFrom(self.signal).map { tuple in tuple.1 }
  }

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  public func takePairWhen <U> (other: Signal<U, Error>) -> Signal<(Value, U), Error> {
    return other.withLatestFrom(self.signal).map { ($0.1, $0.0) }
  }
}

public extension SignalProducerType {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takeWhen <U> (other: Signal<U, Error>) -> Signal<Value, Error> {
    return other.withLatestFrom(self.producer).map { $0.1 }
  }

  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  public func takePairWhen <U> (other: Signal<U, Error>) -> Signal<(Value, U), Error> {
    return other.withLatestFrom(self.producer).map { ($0.1, $0.0) }
  }
}
