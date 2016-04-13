import ReactiveCocoa

extension SignalType {

  /**
   - parameter predicate: A function that determines when to terminate the signal.

   - returns: A signal that emits values up to, and including, when `predicate` returns false. Once
     `predicate` returns false the signal is completed.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func takeUntil(predicate: Value -> Bool) -> Signal<Value, Error> {
    return Signal { observer in
      return self.observe { event in
        if case let .Next(value) = event where !predicate(value) {
          observer.sendNext(value)
          observer.sendCompleted()
        } else {
          observer.action(event)
        }
      }
    }
  }
}

extension SignalProducerType {

  /**
   - parameter predicate: A function that determines when to terminate the signal.

   - returns: A signal that emits values up to, and including, when `predicate` returns false. Once
              `predicate` returns false the signal is completed.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func takeUntil(predicate: Value -> Bool) -> SignalProducer<Value, Error> {
    return lift { $0.takeUntil(predicate) }
  }
}
