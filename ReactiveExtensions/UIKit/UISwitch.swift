#if os(iOS)
import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var on = 0
}

public extension Rac where Object: UISwitch {
  public var on: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object, key: &Associations.on,
        setter: { [weak object] in object?.isOn = $0 },
        getter: { [weak object] in object?.isOn ?? false })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
#endif
