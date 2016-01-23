import ReactiveCocoa

public extension SignalType {

  /// Combines values from two signals only when `self` emits.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func withLatestFrom <U, OtherError: ErrorType> (other: Signal<U, OtherError>) -> Signal<(Value, U), OtherError> {

    return Signal { observer in
      let lock = NSLock()
      lock.name = "org.reactivecocoa.ReactiveCocoa.withLatestFrom"

      let disposable = CompositeDisposable()
      var latestValue: U? = nil

      disposable += other.observe { event in
        switch event {
        case let .Next(value):
          lock.lock()
          latestValue = value
          lock.unlock()
        case let .Failed(error):
          observer.sendFailed(error)
        case .Completed:
          observer.sendCompleted()
        case .Interrupted:
          observer.sendInterrupted()
        }
      }

      disposable += self.signal.observe { event in
        switch event {
        case let .Next(value):
          lock.lock()
          if let latestValue = latestValue {
            observer.sendNext((value, latestValue))
          }
          lock.unlock()
        case .Failed, .Completed, .Interrupted:
          // don't fail, complete or interrupt when the sample does
          break;
        }
      }

      return disposable
    }
  }
}

public extension SignalProducerType {

  /// Combines values from two signals only when `other` emits.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func withLatestFrom <U> (other: SignalProducer<U, Error>) -> SignalProducer<(Value, U), Error> {
    return lift(Signal.combineLatestWith)(other)
  }
}
