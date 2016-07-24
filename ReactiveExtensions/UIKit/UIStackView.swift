import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var axis = 0
}

public extension Rac where Object: UIStackView {
  public var axis: Signal<UILayoutConstraintAxis, NoError> {
    nonmutating set {
      let prop: MutableProperty<UILayoutConstraintAxis> = lazyMutableProperty(
        object, key: &Associations.axis,
        setter: { [weak object] in object?.axis = $0 },
        getter: { [weak object] in object?.axis ?? .Horizontal })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
