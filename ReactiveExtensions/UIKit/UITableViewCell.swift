import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var accessoryType = 0
}

public extension Rac where Object: UITableViewCell {
  var accessoryType: Signal<UITableViewCell.AccessoryType, Never> {
    nonmutating set {
      let prop: MutableProperty<UITableViewCell.AccessoryType> = lazyMutableProperty(
        object,
        key: &Associations.accessoryType,
        setter: { [weak object] in object?.accessoryType = $0 },
        getter: { [weak object] in object?.accessoryType ?? .none })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
