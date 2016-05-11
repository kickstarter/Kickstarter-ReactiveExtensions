import ReactiveCocoa

public extension SignalType {

  /**
   Transforms the signal into one that observes values on the UI thread.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func observeForUI() -> Signal<Value, Error> {
    return self.signal.observeOn(QueueScheduler.mainQueueScheduler)
  }
}

public extension SignalProducerType {

  /**
   Transforms the producer into one that observes values on the UI thread.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func observeForUI() -> SignalProducer<Value, Error> {
    return self.producer.observeOn(QueueScheduler.mainQueueScheduler)
  }
}
