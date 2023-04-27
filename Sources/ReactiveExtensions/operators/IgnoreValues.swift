import ReactiveSwift

public extension Signal {

  /**
   Creates a new signal that emits a void value for every emission of `self`.

   - returns: A new signal.
   */
  func ignoreValues() -> Signal<Void, Error> {
    return signal.map { _ in () }
  }
}

public extension SignalProducer {

  /**
   Creates a new producer that emits a void value for every emission of `self`.

   - returns: A new producer.
   */
  func ignoreValues() -> SignalProducer<Void, Error> {
    return lift { $0.ignoreValues() }
  }
}
