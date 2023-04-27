import ReactiveSwift

public extension Signal {

  /**
   Transforms a signal of `Value`s into a signal of `Optional<Value>`s by simply wrapping each emission.

   - returns: A new signal.
   */
  func wrapInOptional() -> Signal<Value?, Error> {
    return signal.map { x in Optional(x) }
  }
}

public extension SignalProducer {

  /**
   Transforms a producer of `Value`s into a producer of `Optional<Value>`s by simply wrapping each emission.

   - returns: A new producer.
   */
  func wrapInOptional() -> SignalProducer<Value?, Error> {
    return lift { $0.wrapInOptional() }
  }
}
