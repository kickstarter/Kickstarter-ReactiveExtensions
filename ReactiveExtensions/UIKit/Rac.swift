import UIKit

/**
 A type meant to be extended to provide a collection of reactive bindings for
 UIKit views and their subclasses.
 */
public struct Rac<View: RacView> {
  internal let view: View
}

/**
 UIView conforms to this protocol to expose (by extension) a `rac` signal
 namespace scoped by dynamic subclass.
 */
public protocol RacView {}

public extension RacView {
  typealias View = Self

  /**
   A collection of reactive bindings.
  */
  public var rac: Rac<View> {
    return Rac(view: self)
  }
}

extension UIView: RacView {}
