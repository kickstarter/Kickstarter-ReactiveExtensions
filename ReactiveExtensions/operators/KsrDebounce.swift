import ReactiveSwift

public extension Signal {

  /**
   Debounces a signal by a time interval. The resulting signal emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new signal.
   */
  public func ksr_debounce(
    _ interval: @autoclosure @escaping () -> DispatchTimeInterval,
    on scheduler: @autoclosure @escaping () -> DateScheduler) -> Signal<Value, Error> {

    let s = scheduler()
    let d = SerialDisposable()
    let i = interval().timeInterval

    return Signal { observer, _ in

      self.observe { event in
        switch event {
        case let .value(value):
          let date = s.currentDate.addingTimeInterval(i)
          d.inner = s.schedule(after: date) {
            observer.send(value: value)
          }

        case .completed, .failed, .interrupted:
          d.inner = s.schedule {
            observer.send(event)
          }
        }
      }
    }
  }
}

public extension SignalProducer {

  /**
   Debounces a producer by a time interval. The resulting producer emits a value only when `interval` seconds
   have passed since the last emission of `self`.

   - parameter interval:  The time to wait since last emission.
   - parameter scheduler: A scheduler.

   - returns: A new producer.
   */
  public func ksr_debounce(
    _ interval: @autoclosure @escaping () -> DispatchTimeInterval,
    on scheduler: @autoclosure @escaping () -> DateScheduler)
    -> SignalProducer<Value, Error> {

      return lift { $0.ksr_debounce(interval(), on: scheduler()) }
  }
}
