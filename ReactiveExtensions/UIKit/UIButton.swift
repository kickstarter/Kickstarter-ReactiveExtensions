import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var title = 0
}

public extension Rac where Object: UIButton {
  public var title: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.title,
        setter: { [weak object] in object?.setTitle($0, forState: .Normal) },
        getter: { [weak object] in object?.titleLabel?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
