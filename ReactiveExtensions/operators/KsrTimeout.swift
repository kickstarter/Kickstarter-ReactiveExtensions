import ReactiveSwift
import Result

private struct SomeError: Error {}

public extension SignalProtocol {

  /**
   If a signal does not complete within the time interval, it completes without an error.

   - parameter interval:  The time to wait until timing out.
   - parameter scheduler: A scheduler.

   - returns: A new signal.
   */
  public func ksr_timeout(after interval: @autoclosure @escaping () -> DispatchTimeInterval,
                          on scheduler: @autoclosure @escaping () -> DateSchedulerProtocol)
    -> Signal<Value, NoError> {

      return self
        .demoteErrors()
        .timeout(after: interval().timeInterval, raising: SomeError(), on: scheduler())
        .demoteErrors()
  }
}
