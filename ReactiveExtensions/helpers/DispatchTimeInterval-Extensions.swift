import Foundation

extension DispatchTimeInterval {
  var timeInterval: TimeInterval {
    switch self {
    case let .seconds(s):
      return TimeInterval(s)
    case let .milliseconds(ms):
      return TimeInterval(TimeInterval(ms) / 1000.0)
    case let .microseconds(us):
      return TimeInterval(Int64(us) * Int64(NSEC_PER_USEC)) / TimeInterval(NSEC_PER_SEC)
    case let .nanoseconds(ns):
      return TimeInterval(ns) / TimeInterval(NSEC_PER_SEC)
    case .never:
      return .infinity
    @unknown default:
      fatalError()
    }
  }
}
