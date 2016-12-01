import ReactiveCocoa

public extension SignalType {

  /**
   Transform a signal into a window of previous values.

   - parameter max: The maximum number of previous values to use in the window.
   - parameter min: The mininum number of previous values to use in the window.

   - returns: A new signal.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func slidingWindow (max max: Int, min: Int) -> Signal<[Value], Error> {
    return signal
      .scan([Value]()) { window, value in

        if window.count >= max {
          return [Value](window[1..<window.count]) + [value]
        }
        return window + [value]

      }.filter { window in
        return window.count >= min
      }
  }
}

public extension SignalProducerType {

  /**
   Transform a producer into a window of previous values.

   - parameter max: The maximum number of previous values to use in the window.
   - parameter min: The mininum number of previous values to use in the window.

   - returns: A new producer.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func slidingWindow (max max: Int, min: Int) -> SignalProducer<[Value], Error> {
    return lift { $0.slidingWindow(max: max, min: min) }
  }
}
