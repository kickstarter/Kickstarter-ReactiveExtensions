import ReactiveCocoa
import UIKit

extension UIView {

  /// Turns `view.hidden` into a `MutableProperty`.
  public var rac_hidden: MutableProperty<Bool> {
    return lazyMutableProperty(
      self,
      key: &AssociationKey.hidden,
      setter: { self.hidden = $0 },
      getter: { self.hidden }
    )
  }
}
