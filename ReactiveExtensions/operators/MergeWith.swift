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

//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func merge(s1: Signal<Value, Error>,
//                           _ s2: Signal<Value, Error>) -> Signal<Value, Error> {
//
//    return Signal.merge([s1, s2])
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func merge(s1: Signal<Value, Error>,
//                           _ s2: Signal<Value, Error>,
//                           _ s3: Signal<Value, Error>) -> Signal<Value, Error> {
//
//    return Signal.merge([s1, s2, s3])
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func merge(s1: Signal<Value, Error>,
//                           _ s2: Signal<Value, Error>,
//                           _ s3: Signal<Value, Error>,
//                           _ s4: Signal<Value, Error>) -> Signal<Value, Error> {
//
//    return Signal.merge([s1, s2, s3, s4])
//  }
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

//  @warn_unused_result(message="Did you forget to call `start` on the producer?")
//  public static func merge <S: SequenceType where S.Generator.Element == SignalProducer<Value, Error>>
//    (s: S) -> SignalProducer<Value, Error> {
//
//    return SignalProducer(values: s).flatten(.Merge)
//  }
//
//  @warn_unused_result(message="Did you forget to call `start` on the producer?")
//  public static func merge(p1: SignalProducer<Value, Error>,
//                           _ p2: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
//
//    return SignalProducer(values: [p1, p2]).flatten(.Merge)
//  }
//
//  @warn_unused_result(message="Did you forget to call `start` on the producer?")
//  public static func merge(p1: SignalProducer<Value, Error>,
//                           _ p2: SignalProducer<Value, Error>,
//                           _ p3: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
//
//    return SignalProducer(values: [p1, p2, p3]).flatten(.Merge)
//  }
//
//  @warn_unused_result(message="Did you forget to call `start` on the producer?")
//  public static func merge(p1: SignalProducer<Value, Error>,
//                           _ p2: SignalProducer<Value, Error>,
//                           _ p3: SignalProducer<Value, Error>,
//                           _ p4: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
//
//    return SignalProducer(values: [p1, p2, p3, p4]).flatten(.Merge)
//  }
}
