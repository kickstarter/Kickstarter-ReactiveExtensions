import ReactiveCocoa
import Result

extension SignalType where Value: EventType, Error == NoError {
  /**
   - returns: A signal of values of `Next` events from a materialized signal.
   */
  public func values() -> Signal<Value.Value, NoError> {
    return self.signal.map { $0.event.value }.ignoreNil()
  }
}

extension SignalProducerType where Value: EventType, Error == NoError {
  /**
   - returns: A producer of values of `Next` events from a materialized signal.
   */
  public func values() -> SignalProducer<Value.Value, NoError> {
    return lift { $0.values() }
  }
}
