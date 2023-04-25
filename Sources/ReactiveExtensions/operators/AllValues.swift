import ReactiveSwift

public extension SignalProducer {

  /**
   Starts the producer, collects all the values emitted until it completes, and returns an array of all
   values emitted.

   Warning: This should be used only when you know that the signal will complete, otherwise this will
   hang indefinitely.

   - returns: All values emitted by the signal producer.
   */
  func allValues() -> [Value] {
    switch self.producer.collect().last() {
    case .success(let value):
      return value
    default:
      return []
    }
  }
}
