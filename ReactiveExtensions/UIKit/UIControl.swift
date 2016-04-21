import ReactiveCocoa
import Result
import UIKit

public extension Rac where View: UIControl {
  public var enabled: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(view, key: &AssociationKey.enabled,
        setter: { [weak view] in view?.enabled = $0 ?? true },
        getter: { [weak view] in view?.enabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
