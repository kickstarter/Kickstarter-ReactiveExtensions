import Foundation

extension DispatchTimeInterval {
  internal var timeInterval: TimeInterval {
    switch self {
    case let .seconds(interval):
      return TimeInterval(interval)
    case let .milliseconds(interval):
      return TimeInterval(interval) / 1_000
    case let .microseconds(interval):
      return TimeInterval(interval) / 1_000_000
    case let .nanoseconds(interval):
      return TimeInterval(interval) / 1_000_000_000
    }
  }
}
