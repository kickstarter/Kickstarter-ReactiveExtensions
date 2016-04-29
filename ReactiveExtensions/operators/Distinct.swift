import ReactiveCocoa

extension SignalType {

  /**
   Constructs a signal that emits only new, unique values. In order to do this we store an internal set of
   values so that we know when a new value is being emitted. This can inadvertently lead to unbounded
   memory consumption, and so it should be used with signals that do not emit many values.

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

extension SignalProducerType {

  /**
   Constructs a producer that emits only new, unique values. In order to do this we store an internal set of
   values so that we know when a new value is being emitted. This can inadvertently lead to unbounded
   memory consumption, and so it should be used with producers that do not emit many values.

   - parameter keySelector: A function to convert values into `Hashable` values.

   - returns: A producer that emits only distinct values.
   */
  public func distincts <Key: Hashable> (keySelector: Value -> Key) -> SignalProducer<Value, Error> {
    return self.lift { $0.distincts(keySelector) }
  }
}
