import ReactiveCocoa

public extension SignalType {

  /// Emits a value if only `interval` seconds have passed since the last
  /// emission, *and* resets the timer for every new emission.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func debounce(interval: NSTimeInterval, onScheduler scheduler: DateSchedulerType) -> Signal<Value, Error> {
    return flatMap(.Latest) { next in
      SignalProducer(value: next).delay(interval, onScheduler: scheduler)
    }
  }
}

public extension SignalProducerType {

  /// Emits a value if only `interval` seconds have passed since the last
  /// emission, *and* resets the timer for every new emission.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func debounce(interval: NSTimeInterval, onScheduler scheduler: DateSchedulerType) -> SignalProducer<Value, Error> {
    return lift { $0.debounce(interval, onScheduler: scheduler) }
  }
}
