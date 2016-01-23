import ReactiveCocoa
import UIKit

extension UIControl {
  /// Turns `control.enabled` into a `MutableProperty`.
  public var rac_enabled: MutableProperty<Bool> {
    return lazyMutableProperty(
      self,
      key: &AssociationKey.enabled,
      setter: { self.enabled = $0 },
      getter: { self.enabled }
    )
  }
}
