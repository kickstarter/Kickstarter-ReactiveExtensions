import ReactiveSwift

internal extension Event {

  @available(*, deprecated, message: "Rename this to `isValue`.")
  internal var isValue: Bool {
    if case .value = self {
      return true
    }
    return false
  }

  internal var isFailed: Bool {
    if case .failed = self {
      return true
    }
    return false
  }

  internal var isInterrupted: Bool {
    if case .interrupted = self {
      return true
    }
    return false
  }
}
