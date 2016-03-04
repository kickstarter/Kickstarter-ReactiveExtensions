import ReactiveCocoa
import UIKit

extension UITextField {
  /// Turns `field.text` into a `MutableProperty`.
  public var rac_text: MutableProperty<String?> {
    self.addTarget(self, action: #selector(UITextField.rac_text_changed), forControlEvents: .EditingChanged)

    return lazyAssociatedProperty(self, key: &AssociationKey.text) {
      let property = MutableProperty(self.text)
      property.producer.startWithNext { value in
        self.text = value
      }
      return property
    }
  }

  @objc internal func rac_text_changed() {
    rac_text.value = self.text
  }
}
