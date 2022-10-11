internal struct SomeError: Error {
}

extension SomeError: Equatable {}
internal func == (lhs: SomeError, rhs: SomeError) -> Bool {
  return true
}
