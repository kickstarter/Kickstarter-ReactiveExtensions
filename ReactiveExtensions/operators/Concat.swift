// swiftlint:disable line_length
import ReactiveSwift

extension SignalProtocol {

  /**
   Concats a sequence of signals into a single signal.

   - parameter signals: A sequence of signals.

   - returns: A concatenated signal.
   */
  public static func concat
    <Seq: Sequence, S: SignalProtocol>
    (_ signals: Seq) -> Signal<Value, Error> where S.Value == Value, S.Error == Error, Seq.Iterator.Element == S {

    let producer = SignalProducer<S, Error>(signals)
    var result: Signal<Value, Error>!

    producer.startWithSignal { signal, _ in
      result = signal.flatten(.concat)
    }

    return result
  }

  public static func concat<S: SignalProtocol>
    (_ signals: S...) -> Signal<Value, Error> where S.Value == Value, S.Error == Error {

    return Signal.concat(signals)
  }
}

extension SignalProducerProtocol {
  /**
   Concats a sequence of producers into a single producer.

   - parameter producers: A sequence of producers.

   - returns: A concatenated producer.
   */

  public static func concat
    <Seq: Sequence, S: SignalProducerProtocol>
    (_ producers: Seq) -> SignalProducer<Value, Error> where S.Value == Value, S.Error == Error, Seq.Iterator.Element == S {

    return SignalProducer(producers).flatten(.concat)
  }

  public static func concat<S: SignalProducerProtocol>
    (_ producers: S...) -> SignalProducer<Value, Error> where S.Value == Value, S.Error == Error {

    return SignalProducer.concat(producers)
  }
}
