import ReactiveCocoa
import Result
import UIKit

public extension Rac where View: UILabel {
  public var text: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(view, key: &AssociationKey.text,
        setter: { [weak view] in view?.text = $0 ?? "" },
        getter: { [weak view] in view?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
