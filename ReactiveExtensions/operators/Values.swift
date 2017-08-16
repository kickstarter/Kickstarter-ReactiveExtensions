import ReactiveSwift
import Result

extension Signal where Value: EventProtocol, Error == NoError {
  /**
   - returns: A signal of values of `Next` events from a materialized signal.
   */
  public func values() -> Signal<Value.Value, NoError> {
    return self.signal.map { $0.event.value }.skipNil()
  }
}

extension SignalProducer where Value: EventProtocol, Error == NoError {
  /**
   - returns: A producer of values of `Next` events from a materialized signal.
   */
  public func values() -> SignalProducer<Value.Value, NoError> {
    return lift { $0.values() }
  }
}
