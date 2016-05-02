import ReactiveCocoa
import Result

public extension SignalType where Error == NoError {

  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A signal.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func withLatestFrom <U> (other: Signal<U, NoError>) -> Signal<(Value, U), NoError> {

    return Signal { observer in
      let disposable = CompositeDisposable()
      let lastOtherValue: Atomic<U?> = Atomic(nil)

      disposable += other.observe { event in
        switch event {
        case let .Next(value):
          lastOtherValue.swap(value)
        case .Completed:
          // `other` completing does not complete the whole signal.
          break
        case .Failed:
          // Failure is not possible
          break
        case .Interrupted:
          observer.sendInterrupted()
        }
      }

      disposable += self.signal.observe { event in
        switch event {
        case let .Next(value):
          lastOtherValue.withValue { otherValue in
            if let otherValue = otherValue {
              observer.sendNext((value, otherValue))
            }
          }
        case .Completed:
          observer.sendCompleted()
        case .Failed:
          // Failure is not possible
          break
        case .Interrupted:
          observer.sendInterrupted()
        }
      }

      return disposable
    }
  }

  /**
   Transforms the signal into one that emits the most recent values of `self` and `other` only when `self`
   emits.

   - parameter other: A producer.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func withLatestFrom <U> (other: SignalProducer<U, NoError>) -> Signal<(Value, U), NoError> {

    return Signal { observer in
      let disposable = CompositeDisposable()
      let lastOtherValue: Atomic<U?> = Atomic(nil)

      disposable += other.start { event in
        switch event {
        case let .Next(value):
          lastOtherValue.swap(value)
        case .Completed:
          // `other` completing does not complete the whole signal.
          break
        case .Failed:
          // Failure is not possible
          break
        case .Interrupted:
          observer.sendInterrupted()
        }
      }

      disposable += self.signal.observe { event in
        switch event {
        case let .Next(value):
          lastOtherValue.withValue { otherValue in
            if let otherValue = otherValue {
              observer.sendNext((value, otherValue))
            }
          }
        case .Completed:
          observer.sendCompleted()
        case .Failed:
          // Failure is not possible
          break
        case .Interrupted:
          observer.sendInterrupted()
        }
      }

      return disposable
    }
  }
}
