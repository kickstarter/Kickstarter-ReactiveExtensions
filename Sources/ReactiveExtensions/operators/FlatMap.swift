import ReactiveSwift

public extension Signal {

  func flatMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.concat, f)
  }

  func flatMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> Signal<U, Error> {
    return self.signal.flatMap(.concat, f)
  }
}

public extension SignalProducer {

  func flatMap <U> (_ f: @escaping (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.concat, f)
  }

  func flatMap <U> (_ f: @escaping (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
    return self.producer.flatMap(.concat, f)
  }
}
