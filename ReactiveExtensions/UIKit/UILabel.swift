import ReactiveCocoa
import UIKit

extension UILabel {

  /// Turns `label.text` into a `MutableProperty`.
  public var rac_text: MutableProperty<String?> {
    return lazyMutableProperty(
      self,
      key: &AssociationKey.text,
      setter: { self.text = $0 },
      getter: { self.text }
    )
  }
}
