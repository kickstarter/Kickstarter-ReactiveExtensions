import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var alpha = 0
  fileprivate static var backgroundColor = 0
  fileprivate static var endEditing = 0
  fileprivate static var hidden = 0
  fileprivate static var tintColor = 0
}

public extension Rac where Object: UIView {

  public var alpha: Signal<CGFloat, Never> {
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

  public var backgroundColor: Signal<UIColor, Never> {
    nonmutating set {
      let prop: MutableProperty<UIColor> = lazyMutableProperty(object, key: &Associations.backgroundColor,
        setter: { [weak object] in object?.backgroundColor = $0 },
        getter: { [weak object] in object?.backgroundColor ?? .clear })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var endEditing: Signal<(), Never> {
    nonmutating set {
      let prop: MutableProperty = lazyMutableProperty(object, key: &Associations.endEditing,
        setter: { [weak object] in object?.endEditing(true) },
        getter: {})

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var hidden: Signal<Bool, Never> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(object, key: &Associations.hidden,
        setter: { [weak object] in object?.isHidden = $0 },
        getter: { [weak object] in object?.isHidden ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var tintColor: Signal<UIColor, Never> {
    nonmutating set {
      let prop: MutableProperty<UIColor> = lazyMutableProperty(
        object,
        key: &Associations.tintColor,
        setter: { [weak object] in object?.tintColor = $0 },
        getter: { [weak object] in object?.tintColor ?? .clear })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
