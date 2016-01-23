import ReactiveCocoa

public extension SignalType where Value: SequenceType, Value.Generator.Element : Comparable {

  /// Converts a signal of sequences into a signal of **ordered** arrays
  /// by using the sequence element's natural comparator.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  func sort() -> Signal<[Value.Generator.Element], Error> {
    return self.signal.map { x in x.sort() }
  }
}

public extension SignalType where Value: SequenceType {

  /// Transforms a signal of sequences into a signal of ordered arrays using the comparator
  /// function passed in.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func sort(isOrderedBefore: (Value.Generator.Element, Value.Generator.Element) -> Bool) -> Signal<[Value.Generator.Element], Error> {
    return self.signal.map { (x: Value) in x.sort(isOrderedBefore) }
  }
}

public extension SignalProducerType where Value: SequenceType, Value.Generator.Element : Comparable {
  
  /// Given a signal of a sequence of comparables, this maps to a new signal
  /// where each emitted value is a sorted array.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  func sort() -> SignalProducer<[Value.Generator.Element], Error> {
    return lift { $0.sort() }
  }
}

public extension SignalProducerType where Value: SequenceType {

  /// Transforms a signal of sequences into a signal of ordered arrays using the comparator
  /// function passed in.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func sort(isOrderedBefore: (Value.Generator.Element, Value.Generator.Element) -> Bool) -> SignalProducer<[Value.Generator.Element], Error> {
    return lift { $0.sort(isOrderedBefore) }
  }
}
