import ReactiveCocoa

extension SignalProducerType {

  /**
   Starts the producer and returns a new producer that receives all the events, with
   the option of buffering some number of events to be delivered immediately.
  */
  public func startAndShare(replayCount replayCount: Int = 0) -> SignalProducer<Value, Error> {
    let (producer, observer) = SignalProducer<Value, Error>.buffer(replayCount)
    self.producer.start(observer)
    return producer
  }
}
