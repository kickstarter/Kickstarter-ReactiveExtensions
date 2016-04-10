import ReactiveCocoa

public extension SignalType {

  /**
   Merges `self` with another signal.

   - parameter other: The other signal.

   - returns: A merged signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func mergeWith (other: Signal<Value, Error>) -> Signal<Value, Error> {
    return Signal.merge([self.signal, other])
  }

  public static func merge(p1: Signal<Value, Error>,
                           _ p2: Signal<Value, Error>) -> Signal<Value, Error> {

    return Signal.merge([p1, p2])
  }

  public static func merge(p1: Signal<Value, Error>,
                           _ p2: Signal<Value, Error>,
                           _ p3: Signal<Value, Error>) -> Signal<Value, Error> {

    return Signal.merge([p1, p2, p3])
  }

  public static func merge(p1: Signal<Value, Error>,
                           _ p2: Signal<Value, Error>,
                           _ p3: Signal<Value, Error>,
                           _ p4: Signal<Value, Error>) -> Signal<Value, Error> {

    return Signal.merge([p1, p2, p3, p4])
  }
}

public extension SignalProducerType {

  /**
   Merges `self` with another producer.

   - parameter other: The other producer.

   - returns: A merged producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func mergeWith (other: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
    return SignalProducer<SignalProducer<Value, Error>, Error>(values: [self.producer, other]).flatten(.Merge)
  }

  public static func merge <S: SequenceType where S.Generator.Element == SignalProducer<Value, Error>>
    (s: S) -> SignalProducer<Value, Error> {

    return SignalProducer(values: s).flatten(.Merge)
  }

  public static func merge(p1: SignalProducer<Value, Error>,
                           _ p2: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {

    return SignalProducer(values: [p1, p2]).flatten(.Merge)
  }

  public static func merge(p1: SignalProducer<Value, Error>,
                           _ p2: SignalProducer<Value, Error>,
                           _ p3: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {

    return SignalProducer(values: [p1, p2, p3]).flatten(.Merge)
  }

  public static func merge(p1: SignalProducer<Value, Error>,
                           _ p2: SignalProducer<Value, Error>,
                           _ p3: SignalProducer<Value, Error>,
                           _ p4: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {

    return SignalProducer(values: [p1, p2, p3, p4]).flatten(.Merge)
  }
}
