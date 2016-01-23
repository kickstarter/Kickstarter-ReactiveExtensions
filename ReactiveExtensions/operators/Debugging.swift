import ReactiveCocoa

public extension SignalType {

  /// Injects a side effect into a signal so that every event is printed to the console.
  public func printEvents(label: String? = nil) -> Signal<Value, Error> {
    return self.signal.on(event: { e in
      if let label = label { print("[\(label)] \(e)") }
      else                 { print(e) }
    })
  }
}

public extension SignalProducerType {

  /// Print each value in the signal.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func printValues(label label: String? = nil) -> SignalProducer<Value, Error> {
    return self.on { x in
      if let label = label { print("[\(label)] \(x)") }
      else                 { print(x) }
    }
  }

  /// Print each event in the signal.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func printEvents(label label: String? = nil) -> SignalProducer<Value, Error> {
    return self.on(event: { event in
      if let label = label { print("[\(label)] \(event)") }
      else                 { print(event) }
    })
  }

  /// Starts the signal and prints the events observed.
  public func startAndPrintEvents(label label: String? = nil) -> Disposable {
    return producer.start { event in
      if let label = label { print("[\(label)] \(event)") }
      else                 { print(event) }
    }
  }
}
