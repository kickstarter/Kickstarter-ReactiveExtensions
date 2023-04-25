import ReactiveSwift

public extension Signal where Value: Sequence, Value.Iterator.Element: Comparable {

  /**
   Transforms a signal of sequences into a signal of ordered arrays by using the sequence element's
   natural comparator.

   - returns: The sorted signal.
   */
  public func sort() -> Signal<[Value.Iterator.Element], Error> {
    return self.signal.map { x in x.sorted() }
  }
}

public extension Signal where Value: Sequence {

  /**
   Transforms a signal of sequences into a signal of ordered arrays by using the function passed in.

   - parameter isOrderedBefore: A function to compare to elements.

   - returns: The sorted signal.
   */
  public func sort(_ isOrderedBefore: @escaping (Value.Iterator.Element, Value.Iterator.Element) -> Bool) ->
    Signal<[Value.Iterator.Element], Error> {

    return self.signal.map { (x: Value) in x.sorted(by: isOrderedBefore) }
  }
}

public extension SignalProducer where Value: Sequence, Value.Iterator.Element: Comparable {

  /**
   Transforms a producer of sequences into a producer of ordered arrays by using the sequence element's
   natural comparator.

   - returns: The sorted producer.
   */
  public func sort() -> SignalProducer<[Value.Iterator.Element], Error> {
    return self.lift { $0.sort() }
  }
}

public extension SignalProducer where Value: Sequence {

  /**
   Transforms a producer of sequences into a producer of ordered arrays by using the function passed in.

   - parameter isOrderedBefore: A function to compare to elements.

   - returns: The sorted producer.
   */
  public func sort(_ isOrderedBefore: @escaping (Value.Iterator.Element, Value.Iterator.Element) -> Bool)
    -> SignalProducer<[Value.Iterator.Element], Error> {

      return self.lift { $0.sort(isOrderedBefore) }
  }
}
