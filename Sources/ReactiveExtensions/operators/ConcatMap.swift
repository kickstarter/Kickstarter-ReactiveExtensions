import ReactiveSwift

public extension Signal {

  func concatMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.concat, f)
  }

  func concatMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.concat, f)
  }
}

public extension SignalProducer {

  func concatMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.concat, f)
  }

  func concatMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.concat, f)
  }
}
