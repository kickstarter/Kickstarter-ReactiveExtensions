import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var text = 0
}

public extension Rac where Object: UITextView {
  public var text: Signal<String, Never> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.text,
        setter: { [weak object] in object?.text = $0 },
        getter: { [weak object] in object?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
