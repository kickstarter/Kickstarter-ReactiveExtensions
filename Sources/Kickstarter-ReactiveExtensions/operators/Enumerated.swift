import ReactiveSwift

extension Signal {
  /**
   Transforms a signal into one that also emits the index count of the emission, i.e. a signal with emissions

   ```"a", "b", "c", "d", ...```

   is transformed into

   ```(0, "a"), (1, "b"), (2, "c"), (3, "d"), ...```

   - returns: The enumerated signal.
   */
  public func enumerated() -> Signal<(idx: Int, value: Value), Error> {

    let initial: (idx: Int, value: Value?) = (-1, nil)
    return self
      .scan(initial) { accum, value in (accum.idx + 1, value) }
      .map { idx, value in (idx: idx, value: value!) }
  }
}
