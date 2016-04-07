import ReactiveCocoa

public extension SignalType {

  /**
   Maps a signal to a const.

   - parameter value: The constant.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mapConst <U> (value: U) -> Signal<U, Error> {
    return self.signal.map { _ in value }
  }
}

public extension SignalProducerType {

  /**
   Maps a producer to a const.

   - parameter value: The constant.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mapConst <U> (value: U) -> SignalProducer<U, Error> {
    return lift { $0.mapConst(value) }
  }
}
