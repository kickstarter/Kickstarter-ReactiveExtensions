import ReactiveCocoa
import UIKit

extension UITextField {
  /// Turns `field.text` into a `MutableProperty`.
  public var rac_text: MutableProperty<String?> {
    self.addTarget(self, action: "rac_text_changed", forControlEvents: UIControlEvents.EditingChanged)

    return lazyAssociatedProperty(self, key: &AssociationKey.text) {
      let property = MutableProperty(self.text)
      property.producer.startWithNext { value in
        self.text = value
      }
      return property
    }
  }

  private func rac_text_changed() {
    rac_text.value = self.text
  }
}
