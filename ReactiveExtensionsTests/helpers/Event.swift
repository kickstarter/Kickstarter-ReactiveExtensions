import ReactiveCocoa

internal extension Event {
  internal var isNext: Bool {
    if case .Next = self {
      return true
    }
    return false
  }

  internal var isCompleted: Bool {
    if case .Completed = self {
      return true
    }
    return false
  }

  internal var isFailed: Bool {
    if case .Failed = self {
      return true
    }
    return false
  }

  internal var isInterrupted: Bool {
    if case .Interrupted = self {
      return true
    }
    return false
  }
}
