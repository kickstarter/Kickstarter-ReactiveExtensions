import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var enabled = 0
}

public extension Rac where Object: UIBarButtonItem {
  public var enabled: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.enabled,
        setter: { [weak object] in object?.isEnabled = $0 },
        getter: { [weak object] in object?.isEnabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
