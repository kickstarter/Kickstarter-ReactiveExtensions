import ReactiveCocoa

public extension SignalType {

  /**
   A new signal that prints every event emission. The printed string is namespaced by `label`.

   - parameter label: A string to namespace the printed statement.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func printEvents(label: String? = nil) -> Signal<Value, Error> {
    return self.signal.on(event: { e in
      if let label = label {
        print("[\(label)] \(e)")
      } else {
        print(e)
      }
    })
  }
}

public extension SignalProducerType {

  /**
   A new producer that prints every event emission. The printed string is namespaced by `label`.

   - parameter label: A string to namespace the printed statement.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func printEvents(label label: String? = nil) -> SignalProducer<Value, Error> {
    return self.on(event: { event in
      if let label = label {
        print("[\(label)] \(event)")
      } else {
        print(event)
      }
    })
  }
}
