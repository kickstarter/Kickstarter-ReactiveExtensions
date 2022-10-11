public func == <A: Equatable, B: Equatable> (lhs: [(A, B)], rhs: [(A, B)]) -> Bool {
  guard lhs.count == rhs.count else { return false }

  for idx in lhs.indices {
    if lhs[idx] != rhs[idx] {
      return false
    }
  }
  return true
}
