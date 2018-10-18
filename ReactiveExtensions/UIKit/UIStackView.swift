import ReactiveSwift
import Result
import UIKit

private enum Associations {
  fileprivate static var alignment = 0
  fileprivate static var axis = 1
}

public extension Rac where Object: UIStackView {
  public var axis: Signal<NSLayoutConstraint.Axis, NoError> {
    nonmutating set {
      let prop: MutableProperty<NSLayoutConstraint.Axis> = lazyMutableProperty(
        object, key: &Associations.axis,
        setter: { [weak object] in object?.axis = $0 },
        getter: { [weak object] in object?.axis ?? .horizontal })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }

  public var alignment: Signal<UIStackView.Alignment, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIStackView.Alignment> = lazyMutableProperty(
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
