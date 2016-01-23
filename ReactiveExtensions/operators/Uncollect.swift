import ReactiveCocoa

public extension SignalType where Value: SequenceType {
  /// Converts a signal of sequences into a signal of elements by
  /// emitting all elements of each sequence.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func uncollect() -> Signal<Value.Generator.Element, Error> {
    return Signal<Value.Generator.Element, Error> { observer in
      return self.observe { event in
        switch event {
        case let .Next(sequence):
          sequence.forEach(observer.sendNext)
        case let .Failed(error):
          observer.sendFailed(error)
        case .Completed:
          observer.sendCompleted()
        case .Interrupted:
          observer.sendInterrupted()
        }
      }
    }
  }
}

public extension SignalProducerType where Value: SequenceType {
  /// Converts a signal of sequences into a signal of elements by
  /// emitting all elements of each sequence.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func uncollect() -> SignalProducer<Value.Generator.Element, Error> {
    return lift { $0.uncollect() }
  }
}
