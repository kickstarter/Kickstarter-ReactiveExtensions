import ReactiveCocoa

public extension SignalType {
  /// Performs a flatMap(.Merge) on a producer
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mergeMap <U> (f: Value -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Merge, transform: f)
  }

  /// Performs a flatMap(.Merge) on a signal
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mergeMap <U> (f: Value -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Merge, transform: f)
  }
}

public extension SignalProducerType {

  /// Performs a flatMap(.Merge)
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mergeMap <U> (f: Value -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Merge, transform: f)
  }

  /// Performs a flatMap(.Merge)
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mergeMap <U> (f: Value -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Merge, transform: f)
  }
}
