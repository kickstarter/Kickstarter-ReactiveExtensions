import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var enabled = 0
  private static var selected = 1
}

public extension Rac where Object: UIControl {
  public var enabled: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(object, key: &Associations.enabled,
        setter: { [weak object] in object?.enabled = $0 },
        getter: { [weak object] in object?.enabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var selected: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object, key: &Associations.selected,
        setter: { [weak object] in object?.selected = $0 },
        getter: { [weak object] in object?.selected ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
