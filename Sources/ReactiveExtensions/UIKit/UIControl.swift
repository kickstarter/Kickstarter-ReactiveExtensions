import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var enabled = 0
  fileprivate static var selected = 1
}

public extension Rac where Object: UIControl {
  var enabled: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(object, key: &Associations.enabled,
        setter: { [weak object] in object?.isEnabled = $0 },
        getter: { [weak object] in object?.isEnabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  var selected: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object, key: &Associations.selected,
        setter: { [weak object] in object?.isSelected = $0 },
        getter: { [weak object] in object?.isSelected ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
