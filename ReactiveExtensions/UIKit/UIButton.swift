import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var title = 0
  fileprivate static var attributedTitle = 1
}

public extension Rac where Object: UIButton {
  public var title: Signal<String, Never> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.title,
        setter: { [weak object] in object?.setTitle($0, for: .normal) },
        getter: { [weak object] in object?.titleLabel?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var attributedTitle: Signal<NSAttributedString, Never> {
    nonmutating set {
      let prop: MutableProperty<NSAttributedString> = lazyMutableProperty(
        object,
        key: &Associations.attributedTitle,
        setter: { [weak object] in object?.setAttributedTitle($0, for: .normal) },
        getter: { [weak object] in object?.titleLabel?.attributedText ?? NSAttributedString(string: "") })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
