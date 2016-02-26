import ReactiveCocoa

public extension SignalProducerType {

  /**
   Starts the producer, collects all the values emitted until it completes, and returns an array of all
   values emitted.
   
   Warning: This should be used only when you know that the signal will complete, otherwise this will
   hang indefinitely.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func allValues() -> [Value] {
    return self.producer.collect().last()?.value ?? []
  }
}
