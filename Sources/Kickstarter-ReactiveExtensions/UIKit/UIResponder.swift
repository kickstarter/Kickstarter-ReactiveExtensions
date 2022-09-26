import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var becomeFirstResponder = 0
  fileprivate static var firstResponder = 1
}

public extension Rac where Object: UIResponder {
  public var becomeFirstResponder: Signal<(), Never> {
    nonmutating set {
      let prop: MutableProperty<()> = lazyMutableProperty(
        object,
        key: &Associations.becomeFirstResponder,
        setter: { [weak object] in
          object?.becomeFirstResponder()
        },
        getter: { () })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var isFirstResponder: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.firstResponder,
        setter: { [weak object] in
          _ = $0 ? object?.becomeFirstResponder() : object?.resignFirstResponder()
        },
        getter: { [weak object] in object?.isFirstResponder ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
