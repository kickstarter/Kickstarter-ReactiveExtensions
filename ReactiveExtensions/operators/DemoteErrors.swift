import ReactiveCocoa
import Result

public extension SignalType {
  /**
   Demotes the `Error` of this signal to `NoError`, thus preventing it from ever erroring. Essentially the
   inverse of `promoteErrors`.

   - parameter value:  An optional value that will be played in place of the error.
   - parameter errors: An optional observer to send errors to.

   - returns: A new signal that will never error.
   */
  @warn_unused_result(message="Did you forget to call `observe` on the signal?")
  public func demoteErrors(
    replaceErrorWith value: Value? = nil,
                     pipeErrorsTo errors: Observer<Error, NoError>? = nil) -> Signal<Value, NoError> {

    return self.signal
      .on(failed: { error in
        if let errors = errors {
          errors.sendNext(error)
        }
      })
      .flatMapError { error in
        if let value = value {
          return SignalProducer(value: value)
        }
        return SignalProducer.empty
    }
  }
}

public extension SignalProducerType {
  /**
   Demotes the `Error` of the producer to `NoError`, thus preventing it from ever erroring. Essentially the
   inverse of `promoteErrors`.

   - parameter value:  An optional value that will be played in place of the error.
   - parameter errors: An optional observer to send errors to.

   - returns: A new producer that will never error.
   */
  @warn_unused_result(message="Did you forget to call `start` on the producer?")
  public func demoteErrors(
    replaceErrorWith value: Value? = nil,
                     pipeErrorsTo errors: Observer<Error, NoError>? = nil) -> SignalProducer<Value, NoError> {

    return self.lift { $0.demoteErrors(replaceErrorWith: value, pipeErrorsTo: errors) }
  }
}
