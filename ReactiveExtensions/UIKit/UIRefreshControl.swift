#if os(iOS)
import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var isRefreshing = 0
}

public extension Rac where Object: UIRefreshControl {
  public var refreshing: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.isRefreshing,
        setter: { [weak object] in $0 ? object?.beginRefreshing() : object?.endRefreshing() },
        getter: { [weak object] in object?.refreshing ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
#endif
