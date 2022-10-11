import ReactiveSwift

extension Signal {

  /**
   Concats a sequence of signals into a single signal.

   - parameter signals: A sequence of signals.

   - returns: A concatenated signal.
   */
  public static func concat<Seq: Sequence>(_ signals: Seq) -> Signal where Seq.Iterator.Element == Signal {
    let producer = SignalProducer<Signal, Error>(signals)
    var result: Signal!

    producer.startWithSignal { signal, _ in
      result = signal.flatten(.concat)
    }

    return result
  }

  public static func concat(_ signals: Signal...) -> Signal {
    return .concat(signals)
  }
}

extension SignalProducer {
  /**
   Concats a sequence of producers into a single producer.

   - parameter producers: A sequence of producers.

   - returns: A concatenated producer.
   */

  public static func concat<Seq: Sequence>(_ producers: Seq) -> SignalProducer
    where Seq.Iterator.Element == SignalProducer {

      return SignalProducer<SignalProducer, Error>(producers).flatten(.concat)
  }

  public static func concat(_ producers: SignalProducer...) -> SignalProducer {
    return .concat(producers)
  }
}
