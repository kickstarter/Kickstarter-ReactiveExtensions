import ReactiveCocoa

public extension SignalType {

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
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
