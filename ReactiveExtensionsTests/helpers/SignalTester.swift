import ReactiveCocoa

internal class SignalTester <Value, Error: ErrorType> {
  internal var events: [Event<Value, Error>] = []

  internal var nextValues: [Value] {
    return self.events.filter { $0.isNext }.map { $0.value! }
  }

  internal var lastValue: Value? {
    return self.nextValues.last
  }

  internal var hasEmittedValue: Bool {
    return self.lastValue != nil
  }

  internal var failedError: Error? {
    return self.events.filter { $0.isFailed }.map { $0.error! }.first
  }

  internal var didFail: Bool {
    return self.failedError != nil
  }

  internal var didComplete: Bool {
    return self.events.filter { $0.isCompleted }.count > 0
  }

  internal var interruptedEventsCount: Int {
    return self.events.filter { $0.isInterrupted }.count
  }

  internal var didInterrupt: Bool {
    return self.interruptedEventsCount > 0
  }
}
