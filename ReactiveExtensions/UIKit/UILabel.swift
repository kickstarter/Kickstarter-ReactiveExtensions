import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var text = 0
}

public extension Rac where View: UILabel {
  public var text: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        view,
        key: &Associations.text,
        setter: { [weak view] in view?.text = $0 },
        getter: { [weak view] in view?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var font: Signal<UIFont, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIFont> = lazyMutableProperty(
        view,
        key: &Associations.text,
        setter: { [weak view] in view?.font = $0 },
        getter: { [weak view] in view?.font ?? .systemFontOfSize(12.0) })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var textColor: Signal<UIColor, NoError> {
    nonmutating set {
      let prop: MutableProperty<UIColor> = lazyMutableProperty(
        view,
        key: &Associations.text,
        setter: { [weak view] in view?.textColor = $0 },
        getter: { [weak view] in view?.textColor ?? .blackColor() })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
