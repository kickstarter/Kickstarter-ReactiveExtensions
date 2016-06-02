import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var on = 0
}

public extension Rac where Object: UISwitch {
  public var on: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object, key: &Associations.on,
        setter: { [weak object] in object?.on = $0 },
        getter: { [weak object] in object?.on ?? false })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
