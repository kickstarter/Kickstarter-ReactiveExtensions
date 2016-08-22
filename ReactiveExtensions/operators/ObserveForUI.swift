import ReactiveCocoa

public extension SignalType {

  /**
   Transforms the signal into one that observes values on the UI thread.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func observeForUI() -> Signal<Value, Error> {
    return self.signal.observeOn(UIScheduler())
  }

  /**
   Transforms the signal into one that can perform actions for a controller. Use this operator when doing
   any side-effects from a controller. We've found that `UIScheduler` can be problematic with many
   controller actions, such as presenting and dismissing of view controllers.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func observeForControllerAction() -> Signal<Value, Error> {
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
    return self.producer.observeOn(UIScheduler())
  }
}
