import ReactiveSwift

public extension Signal {

  func switchMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.latest, f)
  }

  func switchMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.latest, f)
  }
}

public extension SignalProducer {

  func switchMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.latest, f)
  }

  func switchMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.latest, f)
  }
}
