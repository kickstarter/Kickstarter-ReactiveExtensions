import ReactiveSwift
import Result

extension Signal where Value: EventProtocol, Error == NoError {
  /**
   - returns: A signal of errors of `Error` events from a materialized signal.
   */
  public func errors() -> Signal<Value.Error, NoError> {
    return self.signal.map { $0.event.error }.skipNil()
  }
}

extension SignalProducer where Value: EventProtocol, Error == NoError {
  /**
   - returns: A producer of errors of `Error` events from a materialized signal.
   */
  public func errors() -> SignalProducer<Value.Error, NoError> {
    return self.lift { $0.errors() }
  }
}
