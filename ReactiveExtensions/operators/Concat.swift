import ReactiveCocoa

extension SignalType {

  /**
   Concats a sequence of signals into a single signal.

   - parameter signals: A sequence of signals.

   - returns: A concatenated signal.
   */
//  public static func concat<S: SequenceType where S.Generator.Element == Signal<Value, Error>>
//    (signals: S) -> Signal<Value, Error> {
//
//      let producer = SignalProducer<Signal<Value, Error>, Error>(values: signals)
//      var result: Signal<Value, Error>!
//      producer.startWithSignal { (signal, _) in
//        result = signal.flatten(.Concat)
//      }
//      return result
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func concat(s1: Signal<Value, Error>,
//                            _ s2: Signal<Value, Error>) -> Signal<Value, Error> {
//
//    return Signal.concat([s1, s2])
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func concat(s1: Signal<Value, Error>,
//                            _ s2: Signal<Value, Error>,
//                            _ s3: Signal<Value, Error>) -> Signal<Value, Error> {
//
//    return Signal.concat([s1, s2, s3])
//  }
}

extension SignalProducerType {

  /**
   Concats a sequence of producers into a single producer.

   - parameter producers: A sequence of producers.

   - returns: A concatenated producer.
   */
//  public static func concat<S: SequenceType where S.Generator.Element == SignalProducer<Value, Error>>
//    (producers: S) -> SignalProducer<Value, Error> {
//
//    return SignalProducer(values: producers).flatten(.Concat)
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func concat(s1: SignalProducer<Value, Error>,
//                            _ s2: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
//
//    return SignalProducer.concat([s1, s2])
//  }
//
//  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
//  public static func concat(s1: SignalProducer<Value, Error>,
//                            _ s2: SignalProducer<Value, Error>,
//                            _ s3: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
//
//    return SignalProducer.concat([s1, s2, s3])
//  }
}
