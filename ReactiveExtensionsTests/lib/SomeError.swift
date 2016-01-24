internal struct SomeError : ErrorType {
}

extension SomeError : Equatable {}
internal func == (lhs: SomeError, rhs: SomeError) -> Bool {
  return true
}
