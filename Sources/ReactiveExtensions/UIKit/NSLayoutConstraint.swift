import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var constant = 0
}

public extension Rac where Object: NSLayoutConstraint {
  var constant: Signal<CGFloat, Never> {
    nonmutating set {
      let prop: MutableProperty<CGFloat> = lazyMutableProperty(
        object,
        key: &Associations.constant,
        setter: { [weak object] in object?.constant = $0 },
        getter: { [weak object] in object?.constant ?? 0.0 })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
