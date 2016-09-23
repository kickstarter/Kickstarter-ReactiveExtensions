import ReactiveCocoa

public extension SignalType {

  /**
   Transforms the signal into one that observes values on the global background queue
   with default priority or the priority determined by the optional parameter.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func observeForBackground(queuePriority queuePriority:
    dispatch_queue_priority_t = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> Signal<Value, Error> {
    return self.signal.observeOn(QueueScheduler(queue:
      dispatch_get_global_queue(queuePriority, 0)))
  }
}

public extension SignalProducerType {

  /**
   Transforms the producer into one that observes values on the global background queue
   with default priority or the priority determined by the optional parameter.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func observeForUI(queuePriority queuePriority:
    dispatch_queue_priority_t = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> SignalProducer<Value, Error> {
    return self.producer.observeOn(QueueScheduler(queue:
      dispatch_get_global_queue(queuePriority, 0)))
  }
}
