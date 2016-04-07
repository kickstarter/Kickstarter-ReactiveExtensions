import ReactiveCocoa

public extension SignalType {

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func switchMap <U> (f: Value -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Latest, transform: f)
  }

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func switchMap <U> (f: Value -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.Latest, transform: f)
  }
}

public extension SignalProducerType {

  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func switchMap <U> (f: Value -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Latest, transform: f)
  }

  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func switchMap <U> (f: Value -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.Latest, transform: f)
  }
}
