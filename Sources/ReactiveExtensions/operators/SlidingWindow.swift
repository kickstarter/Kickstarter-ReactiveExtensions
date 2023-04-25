import ReactiveSwift

public extension Signal {

  /**
   Transform a signal into a window of previous values.

   - parameter max: The maximum number of previous values to use in the window.
   - parameter min: The mininum number of previous values to use in the window.

   - returns: A new signal.
   */
  public func slidingWindow(max: Int, min: Int) -> Signal<[Value], Error> {
    return signal
      .scan([]) { (window: [Value], value: Value) -> [Value] in
        let scope = window.count >= max ? Array(window[1..<window.count]) : window
        return scope + [value]
      }.filter { window in
        return window.count >= min
      }
  }
}

public extension SignalProducer {

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
