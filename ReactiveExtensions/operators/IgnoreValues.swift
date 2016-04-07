import ReactiveCocoa

public extension SignalType {

  /**
   Creates a new signal that emits a void value for every emission of `self`.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func ignoreValues() -> Signal<Void, Error> {
    return signal.map { _ in () }
  }
}

public extension SignalProducerType {

  /**
   Creates a new producer that emits a void value for every emission of `self`.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func ignoreValues() -> SignalProducer<Void, Error> {
    return lift { $0.ignoreValues() }
  }
}
