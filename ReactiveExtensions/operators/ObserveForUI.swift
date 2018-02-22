import ReactiveSwift

public extension Signal {

  /**
   Transforms the signal into one that observes values on the UI thread.

   - returns: A new signal.
   */
  public func observeForUI() -> Signal<Value, Error> {
    return self.signal.observe(on: UIScheduler())
  }

  /**
   Transforms the signal into one that can perform actions for a controller. Use this operator when doing
   any side-effects from a controller. We've found that `UIScheduler` can be problematic with many
   controller actions, such as presenting and dismissing of view controllers.

   - returns: A new signal.
   */
  public func observeForControllerAction() -> Signal<Value, Error> {
    return self.signal.observe(on: QueueScheduler.main)
  }
}

public extension SignalProducer {

  /**
   Transforms the producer into one that observes values on the UI thread.

   - returns: A new producer.
   */
  public func observeForUI() -> SignalProducer<Value, Error> {
    return self.producer.observe(on: UIScheduler())
  }
}
