import Foundation
import ReactiveCocoa

/**
 Associates a key/`MutableProperty` pair to a host object.
 
 - parameters:
   - host:
   - key:
   - setter:
   - getter:
 
 - returns:
*/
internal func lazyMutableProperty<T>(host: AnyObject, key: UnsafePointer<Void>, setter: T -> (), getter: () -> T) -> MutableProperty<T> {
  return lazyAssociatedProperty(host, key: key) {
    let property = MutableProperty<T>(getter())
    property.producer.startWithNext { value in
      setter(value)
    }
    return property
  }
}
