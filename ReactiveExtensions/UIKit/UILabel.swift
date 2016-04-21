import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var text = 0
}

public extension Rac where View: UILabel {
  public var text: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(view, key: &Associations.text,
        setter: { [weak view] in view?.text = $0 ?? "" },
        getter: { [weak view] in view?.text ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}
