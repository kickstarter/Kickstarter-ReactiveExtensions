import ReactiveCocoa

public extension SignalType {

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A signal.

   - returns: A new signal.
   */
  public func withLatestFrom <U, OtherError: ErrorType> (other: Signal<U, OtherError>) ->
    Signal<(Value, U), OtherError> {

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
          // don't fail, complete or interrupt when the other does
          break
        }
      }

      return disposable
    }
  }

  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A producer.

   - returns: A new signal.
   */
  public func withLatestFrom <U, OtherError: ErrorType> (other: SignalProducer<U, OtherError>) ->
    Signal<(Value, U), OtherError> {

    return Signal { observer in
      let lock = NSLock()
      lock.name = "org.reactivecocoa.ReactiveCocoa.withLatestFrom"

      let disposable = CompositeDisposable()
      var latestValue: U? = nil

      disposable += other.start { event in
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
          // don't fail, complete or interrupt when the other does
          break
        }
      }

      return disposable
    }
  }
}
