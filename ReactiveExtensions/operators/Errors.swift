import ReactiveSwift

extension Signal where Value: EventProtocol, Error == Never {
  /**
   - returns: A signal of errors of `Error` events from a materialized signal.
   */
  public func errors() -> Signal<Value.Error, Never> {
    return self.signal.map { $0.event.error }.skipNil()
  }
}

extension SignalProducer where Value: EventProtocol, Error == Never {
  /**
   - returns: A producer of errors of `Error` events from a materialized signal.
   */
  public func errors() -> SignalProducer<Value.Error, Never> {
    return self.lift { $0.errors() }
  }
}

/*
 Derived from https://gist.github.com/Qata/c4644f02ca56467c1ce6ece34094f970
 to reverse the changes in https://github.com/ReactiveCocoa/ReactiveSwift/pull/577
 so that all termination events are delayed if required.
 */
extension Signal {
  // Turn the producer from a Signal<Result<Value, Error>, Never> into a Signal<Value, Error>.
  public func liftSubduedError<T, E>() -> Signal<T, E> where Value == Result<T, E>, Error == Never {
    return materialize()
      .map { event -> Signal<T, E>.Event in
        switch event {
        case let .value(.success(value)):
          return .value(value)
        case let .value(.failure(error)):
          return .failed(error)
        case .failed:
          fatalError("NoError is impossible to construct")
        case .completed:
          return .completed
        case .interrupted:
          return .interrupted
        }
      }
      .dematerialize()
  }

  // Turn the producer from a Signal<Value, Error> into a Signal<Result<Value, Error>, Never>.
  public func subdueError() -> Signal<Result<Value, Error>, Never> {
    return materialize()
      .flatMap(.concat) { event -> SignalProducer<Signal<Result<Value, Error>, Never>.Event, Never> in
        switch event {
        case let .value(value):
          return .init(value: .value(.success(value)))
        case let .failed(error):
          return .init([ .value(.failure(error)), .completed ])
        case .completed:
          return .init(value: .completed)
        case .interrupted:
          return .init(value: .interrupted)
        }
      }
      .dematerialize()
  }
}

extension SignalProducer {
  // Turn the producer from a SignalProducer<Result<Value, Error>, Never>
  // into a SignalProducer<Value, Error>.
  public func liftSubduedError<T, E>() -> SignalProducer<T, E> where Value == Result<T, E>, Error == Never {
    return lift { $0.liftSubduedError() }
  }

  // Turn the producer from a SignalProducer<Value, Error>
  // into a SignalProducer<Result<Value, Error>, Never>.
  public func subdueError() -> SignalProducer<Result<Value, Error>, Never> {
    return lift { $0.subdueError() }
  }
}
