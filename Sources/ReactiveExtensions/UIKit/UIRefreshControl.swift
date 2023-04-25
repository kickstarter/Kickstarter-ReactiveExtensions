#if os(iOS)
import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var isRefreshing = 0
}

public extension Rac where Object: UIRefreshControl {
  public var refreshing: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.isRefreshing,
        setter: { [weak object] in $0 ? object?.beginRefreshing() : object?.endRefreshing() },
        getter: { [weak object] in object?.isRefreshing ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
#endif
