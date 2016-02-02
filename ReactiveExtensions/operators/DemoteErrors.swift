import ReactiveCocoa
import Result

public extension SignalType {

  /// Demotes the `Error` of this signal to `NoError`, thus preventing it from ever
  /// erroring. Essentially the inverse of `promoteErrors`.
  ///
  /// An optional observer of type `<Error, NoError>` can be given that will be
  /// fed any error that is propogated.
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func demoteErrors(errorObserver: Observer<Error, NoError>? = nil) -> Signal<Value, NoError> {

    return self.signal
      .on(failed: { error in
        if let errorObserver = errorObserver {
          errorObserver.sendNext(error)
        }
      })
      .flatMapError { error in
        return SignalProducer.empty
    }
  }
}

public extension SignalProducerType {

  /// Demotes the `Error` of this signal to `NoError`, thus preventing it from ever
  /// erroring. Essentially the inverse of `promoteErrors`.
  ///
  /// An optional observer of type `<Error, NoError>` can be given that will be
  /// fed any error that is propogated.
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func demoteErrors(errorObserver: Observer<Error, NoError>? = nil) -> SignalProducer<Value, NoError> {
    return self.lift { $0.demoteErrors(errorObserver) }
  }
}
