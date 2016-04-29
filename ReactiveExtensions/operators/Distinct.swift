import ReactiveCocoa

extension SignalType where Value: Hashable {

  /**
   - returns: A signal that emits only distinct values.
   */
  public func distincts() -> Signal<Value, Error> {
    return self.distincts { $0 }
  }
}

extension SignalType {

  /**
   - parameter keySelector: A function to convert values into `Hashable` values.

   - returns: A signal that emits only distinct values.
   */
  public func distincts <Key: Hashable> (keySelector: Value -> Key) -> Signal<Value, Error> {
    return Signal { observer in
      var keys: Set<Key> = []

      return self.observe { event in
        switch event {
        case let .Next(value):
          let key = keySelector(value)
          if !keys.contains(key) {
            keys.insert(key)
            observer.sendNext(value)
          }
        case .Completed:
          observer.sendCompleted()
        case let .Failed(error):
          observer.sendFailed(error)
        case .Interrupted:
          observer.sendInterrupted()
        }
      }
    }
  }
}

extension SignalProducerType where Value: Hashable {

  /**
   - returns: A signal producer that emits only distinct values.
   */
  public func distincts() -> SignalProducer<Value, Error> {
    return self.lift { $0.distincts() }
  }
}

extension SignalProducerType {

  /**
   - parameter keySelector: A function to convert values into `Hashable` values.

   - returns: A signal producer that emits only distinct values.
   */
  public func distincts <Key: Hashable> (keySelector: Value -> Key) -> SignalProducer<Value, Error> {
    return self.lift { $0.distincts(keySelector) }
  }
}
