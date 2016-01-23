import ReactiveCocoa

public extension SignalType {

  /// Performs a flatMap(.Concat) on a producer
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func concatMap <U> (f: Value -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Concat, transform: f)
  }

  /// Performs a flatMap(.Concat) on a signal
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func concatMap <U> (f: Value -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Concat, transform: f)
  }
}

public extension SignalProducerType {

  /// Performs a flatMap(.Concat)
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func concatMap <U> (f: Value -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Concat, transform: f)
  }

  /// Performs a flatMap(.Concat)
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func concatMap <U> (f: Value -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Concat, transform: f)
  }
}
