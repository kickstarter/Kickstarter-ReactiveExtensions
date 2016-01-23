import ReactiveCocoa

public extension SignalType {

  /// Observe values on the UI thread.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func observeForUI() -> Signal<Value, Error> {
    return signal.observeOn(UIScheduler())
  }
}

public extension SignalProducerType {

  /// Observe values on the UI thread.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func observeForUI() -> SignalProducer<Value, Error> {
    return lift { $0.observeForUI() }
  }
}
