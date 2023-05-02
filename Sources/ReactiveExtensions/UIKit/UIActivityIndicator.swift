import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var animating = 0
}

public extension Rac where Object: UIActivityIndicatorView {
  var animating: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.animating,
        setter: { [weak object] in $0 ? object?.startAnimating() : object?.stopAnimating() },
        getter: { [weak object] in object?.isAnimating ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
