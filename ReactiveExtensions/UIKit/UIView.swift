import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var alpha = 0
  private static var backgroundColor = 0
  private static var hidden = 0
}

public extension Rac where View: UIView {

  public var alpha: Signal<CGFloat, NoError> {
    nonmutating set {
      let prop: MutableProperty<CGFloat> = lazyMutableProperty(view, key: &Associations.alpha,
        setter: { [weak view] in view?.alpha = $0 },
        getter: { [weak view] in view?.alpha ?? 1.0 })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var backgroundColor: Signal<UIColor, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIColor> = lazyMutableProperty(view, key: &Associations.backgroundColor,
        setter: { [weak view] in view?.backgroundColor = $0 },
        getter: { [weak view] in view?.backgroundColor ?? .clearColor() })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var hidden: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(view, key: &Associations.hidden,
        setter: { [weak view] in view?.hidden = $0 },
        getter: { [weak view] in view?.hidden ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
