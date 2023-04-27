import ReactiveSwift

public extension Signal {

  func mergeMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.merge, f)
  }

  func mergeMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.merge, f)
  }
}

public extension SignalProducer {

  func mergeMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.merge, f)
  }

  func mergeMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.merge, f)
  }
}
