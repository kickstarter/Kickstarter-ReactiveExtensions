import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var firstResponder = 0
}

public extension Rac where Object: UIResponder {
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
