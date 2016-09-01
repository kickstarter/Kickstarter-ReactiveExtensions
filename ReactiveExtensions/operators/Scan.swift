import ReactiveCocoa

public extension SignalType {

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  /**
   Scans a signal without providing an initial value. The first emission of `self` will be emitted
   immediately, and subsequent emissions will be processed by the `combine` function.

   - parameter combine: The combining function used to scan the signal.

   - returns: A new signal.
   */
  public func scan(combine: (Value, Value) -> Value) -> Signal<Value, Error> {
    return Signal { observer in
      var accumulated: Value? = nil

      return self.observe { event in
        observer.action(event.map { value in
          if let unwrapped = accumulated {
            let next = combine(unwrapped, value)
            accumulated = next
            return next
          }
          accumulated = value
          return value
          })
      }
    }
  }
}
