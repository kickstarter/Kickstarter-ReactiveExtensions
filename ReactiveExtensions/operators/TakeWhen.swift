import ReactiveCocoa
import Result

public extension SignalType where Error == NoError {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takeWhen <U> (other: Signal<U, NoError>) -> Signal<Value, NoError> {
    return other.withLatestFrom(self.signal).map { tuple in tuple.1 }
  }

  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another signal.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takePairWhen <U> (other: Signal<U, NoError>) -> Signal<(Value, U), NoError> {
    return other.withLatestFrom(self.signal).map { ($0.1, $0.0) }
  }
}

public extension SignalProducerType where Error == NoError {

  /**
   Emits the most recent value of `self` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takeWhen <U> (other: Signal<U, NoError>) -> Signal<Value, NoError> {
    return other.withLatestFrom(self.producer).map { $0.1 }
  }

  /**
   Emits the most recent value of `self` and `other` when `other` emits.

   - parameter other: Another producer.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takePairWhen <U> (other: Signal<U, NoError>) -> Signal<(Value, U), NoError> {
    return other.withLatestFrom(self.producer).map { ($0.1, $0.0) }
  }
}
