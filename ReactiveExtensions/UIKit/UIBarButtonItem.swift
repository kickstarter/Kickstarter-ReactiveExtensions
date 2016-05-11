import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var enabled = 0
}

public extension Rac where Object: UIBarButtonItem {
  public var enabled: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.enabled,
        setter: { [weak object] in object?.enabled = $0 ?? true },
        getter: { [weak object] in object?.enabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
