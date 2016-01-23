import ReactiveCocoa

public extension SignalType {

  /// Performs a `map.ignoreNil` for the case when you are mapping
  /// to an optional value
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func flatMap <U> (f: Value -> U?) -> Signal<U, Error> {
    return self.signal.map { f($0) }.ignoreNil()
  }

  /// Performs a flatMap(.Concat) on a producer
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func flatMap <U> (f: Value -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Concat, transform: f)
  }

  /// Performs a flatMap(.Concat) on a signal
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func flatMap <U> (f: Value -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Concat, transform: f)
  }
}

public extension SignalProducerType {

  /// Performs a `map.ignoreNil` for the case when you are mapping
  /// to an optional value
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func flatMap <U> (f: Value -> U?) -> SignalProducer<U, Error> {
    return lift { $0.flatMap(f) }
  }

  /// Performs a flatMap(.Concat)
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func flatMap <U> (f: Value -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Concat, transform: f)
  }
}
