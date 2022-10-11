import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var title = 0
}

public extension Rac where Object: UINavigationItem {
  public var title: Signal<String, Never> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.title,
        setter: { [weak object] in object?.title = $0 },
        getter: { [weak object] in object?.title ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
