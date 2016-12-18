import ReactiveSwift
import Result
import UIKit

private enum Associations {
  fileprivate static var alignment = 0
  fileprivate static var axis = 1
}

public extension Rac where Object: UIStackView {
  public var axis: Signal<UILayoutConstraintAxis, NoError> {
    nonmutating set {
      let prop: MutableProperty<UILayoutConstraintAxis> = lazyMutableProperty(
        object, key: &Associations.axis,
        setter: { [weak object] in object?.axis = $0 },
        getter: { [weak object] in object?.axis ?? .horizontal })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }

  public var alignment: Signal<UIStackViewAlignment, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIStackViewAlignment> = lazyMutableProperty(
        object, key: &Associations.alignment,
        setter: { [weak object] in object?.alignment = $0 },
        getter: { [weak object] in object?.alignment ?? .fill })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
