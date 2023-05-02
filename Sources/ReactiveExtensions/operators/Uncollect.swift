import ReactiveSwift

public extension Signal where Value: Sequence {
  /**
   Transforms a signal of sequences into a signal of elements by emitting all elements of each sequence.

   - returns: A new signal.
   */
  func uncollect() -> Signal<Value.Iterator.Element, Error> {
    return Signal<Value.Iterator.Element, Error> { observer, _ in
      self.observe { event in
        switch event {
        case let .value(sequence):
          sequence.forEach(observer.send(value:))
        case let .failed(error):
          observer.send(error: error)
        case .completed:
          observer.sendCompleted()
        case .interrupted:
          observer.sendInterrupted()
        }
      }
    }
  }
}

public extension SignalProducer where Value: Sequence {
  /**
   Transforms a producer of sequences into a producer of elements by emitting all elements of each sequence.

   - returns: A new producer.
   */
  func uncollect() -> SignalProducer<Value.Iterator.Element, Error> {
    return lift { $0.uncollect() }
  }
}
