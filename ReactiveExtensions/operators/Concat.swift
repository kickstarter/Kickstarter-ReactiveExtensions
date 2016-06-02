// swiftlint:disable line_length
import ReactiveCocoa

extension SignalType {

  /**
   Concats a sequence of signals into a single signal.

   - parameter signals: A sequence of signals.

   - returns: A concatenated signal.
   */
  public static func concat
    <Seq: SequenceType, S: SignalType where S.Value == Value, S.Error == Error, Seq.Generator.Element == S>
    (signals: Seq) -> Signal<Value, Error> {

    let producer = SignalProducer<S, Error>(values: signals)
    var result: Signal<Value, Error>!

    producer.startWithSignal { signal, _ in
      result = signal.flatten(.Concat)
    }

    return result
  }

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public static func concat<S: SignalType where S.Value == Value, S.Error == Error>
    (signals: S...) -> Signal<Value, Error> {

    return Signal.concat(signals)
  }
}

extension SignalProducerType {
  /**
   Concats a sequence of producers into a single producer.

   - parameter producers: A sequence of producers.

   - returns: A concatenated producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public static func concat
    <Seq: SequenceType, S: SignalProducerType where S.Value == Value, S.Error == Error, Seq.Generator.Element == S>
    (producers: Seq) -> SignalProducer<Value, Error> {

    return SignalProducer(values: producers).flatten(.Concat)
  }

  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public static func concat<S: SignalProducerType where S.Value == Value, S.Error == Error>
    (producers: S...) -> SignalProducer<Value, Error> {

    return SignalProducer.concat(producers)
  }
}
