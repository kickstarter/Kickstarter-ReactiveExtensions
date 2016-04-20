import ReactiveCocoa
import Result
import UIKit

public struct RacLabel {
  private let label: UILabel

  public var text: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(label, key: &AssociationKey.text,
        setter: { [weak label] in label?.text = $0 ?? "" },
        getter: { [weak label] in label?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}

extension UILabel {
  public var rac: RacLabel {
    return RacLabel(label: self)
  }
}
