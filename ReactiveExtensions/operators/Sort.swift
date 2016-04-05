import ReactiveCocoa

public extension SignalType where Value: SequenceType, Value.Generator.Element: Comparable {

  /**
   Transforms a signal of sequences into a signal of ordered arrays by using the sequence element's
   natural comparator.

   - returns: The sorted signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  func sort() -> Signal<[Value.Generator.Element], Error> {
    return self.signal.map { x in x.sort() }
  }
}

public extension SignalType where Value: SequenceType {

  /**
   Transforms a signal of sequences into a signal of ordered arrays by using the function passed in.

   - parameter isOrderedBefore: A function to compare to elements.

   - returns: The sorted signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func sort(isOrderedBefore: (Value.Generator.Element, Value.Generator.Element) -> Bool) ->
    Signal<[Value.Generator.Element], Error> {

    return self.signal.map { (x: Value) in x.sort(isOrderedBefore) }
  }
}

public extension SignalProducerType where Value: SequenceType, Value.Generator.Element: Comparable {

  /**
   Transforms a producer of sequences into a producer of ordered arrays by using the sequence element's
   natural comparator.

   - returns: The sorted producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  func sort() -> SignalProducer<[Value.Generator.Element], Error> {
    return lift { $0.sort() }
  }
}

public extension SignalProducerType where Value: SequenceType {

  /**
   Transforms a producer of sequences into a producer of ordered arrays by using the function passed in.

   - parameter isOrderedBefore: A function to compare to elements.

   - returns: The sorted producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func sort(isOrderedBefore: (Value.Generator.Element, Value.Generator.Element) -> Bool) ->
    SignalProducer<[Value.Generator.Element], Error> {

    return lift { $0.sort(isOrderedBefore) }
  }
}
