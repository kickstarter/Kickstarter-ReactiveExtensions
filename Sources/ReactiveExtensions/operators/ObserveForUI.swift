import ReactiveSwift

public extension Signal {

  /**
   Transforms the signal into one that observes values on the UI thread.

   - returns: A new signal.
   */
  func observeForUI() -> Signal<Value, Error> {
    return self.signal.observe(on: UIScheduler())
  }

  /**
   Transforms the signal into one that can perform actions for a controller. Use this operator when doing
   any side-effects from a controller. We've found that `UIScheduler` can be problematic with many
   controller actions, such as presenting and dismissing of view controllers.

   - returns: A new signal.
   */
  func observeForControllerAction() -> Signal<Value, Error> {
    return self.signal.observe(on: QueueScheduler.main)
  }
}

public extension SignalProducer {

  /**
   Transforms the producer into one that observes values on the UI thread.

   - returns: A new producer.
   */
  func observeForUI() -> SignalProducer<Value, Error> {
    return self.producer.observe(on: UIScheduler())
  }
}
