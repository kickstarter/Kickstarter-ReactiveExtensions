import ReactiveSwift

public extension SignalProtocol {

  /**
   Transform a signal into a window of previous values.

   - parameter max: The maximum number of previous values to use in the window.
   - parameter min: The mininum number of previous values to use in the window.

   - returns: A new signal.
   */
  public func slidingWindow (max: Int, min: Int) -> Signal<[Value], Error> {
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

public extension SignalProducerProtocol {

  /**
   Transform a producer into a window of previous values.

   - parameter max: The maximum number of previous values to use in the window.
   - parameter min: The mininum number of previous values to use in the window.

   - returns: A new producer.
   */
  public func slidingWindow (max: Int, min: Int) -> SignalProducer<[Value], Error> {
    return lift { $0.slidingWindow(max: max, min: min) }
  }
}
