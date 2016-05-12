import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var alpha = 0
  private static var backgroundColor = 0
  private static var hidden = 0
}

public extension Rac where Object: UIView {

  public var alpha: Signal<CGFloat, NoError> {
    nonmutating set {
      let prop: MutableProperty<CGFloat> = lazyMutableProperty(object, key: &Associations.alpha,
        setter: { [weak object] in object?.alpha = $0 },
        getter: { [weak object] in object?.alpha ?? 1.0 })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var backgroundColor: Signal<UIColor, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIColor> = lazyMutableProperty(object, key: &Associations.backgroundColor,
        setter: { [weak object] in object?.backgroundColor = $0 },
        getter: { [weak object] in object?.backgroundColor ?? .clearColor() })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var hidden: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(object, key: &Associations.hidden,
        setter: { [weak object] in object?.hidden = $0 },
        getter: { [weak object] in object?.hidden ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
