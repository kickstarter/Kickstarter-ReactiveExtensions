import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var enabled = 0
}

public extension Rac where View: UIControl {
  public var enabled: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(view, key: &Associations.enabled,
        setter: { [weak view] in view?.enabled = $0 ?? true },
        getter: { [weak view] in view?.enabled ?? true })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
