import ReactiveCocoa

public extension SignalType {

  /**
   Debounces a signal by a time interval. The resulting signal emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func ksr_debounce(
    @autoclosure(escaping) interval: () -> NSTimeInterval,
    @autoclosure(escaping) onScheduler scheduler: () -> DateSchedulerType) ->
    Signal<Value, Error> {

      return self.debounce(interval(), onScheduler: scheduler())
  }
}

public extension SignalProducerType {

  /**
   Debounces a producer by a time interval. The resulting producer emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func ksr_debounce(
    @autoclosure(escaping) interval: () -> NSTimeInterval,
    @autoclosure(escaping) onScheduler scheduler: () -> DateSchedulerType) ->
    SignalProducer<Value, Error> {

      return lift { $0.debounce(interval(), onScheduler: scheduler()) }
  }
}
