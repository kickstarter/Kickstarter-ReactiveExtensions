import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var becomeFirstResponder = 0
  private static var firstResponder = 1
}

public extension Rac where Object: UIResponder {
  public var becomeFirstResponder: Signal<(), NoError> {
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

  public var isFirstResponder: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.firstResponder,
        setter: { [weak object] in $0 ? object?.becomeFirstResponder() : object?.resignFirstResponder() },
        getter: { [weak object] in object?.isFirstResponder() ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
