import ReactiveSwift
import UIKit

private enum Associations {
  fileprivate static var maximumValue = 0
  fileprivate static var minimumValue = 0
  fileprivate static var stepValue = 0
  fileprivate static var value = 0
}

public extension Rac where Object: UIStepper {
  var maximumValue: Signal<Double, Never> {
    nonmutating set {
      let prop: MutableProperty<Double> = lazyMutableProperty(
        object, key: &Associations.maximumValue,
        setter: { [weak object] in object?.maximumValue = $0 },
        getter: { [weak object] in object?.maximumValue ?? 100.0 })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }

  var minimumValue: Signal<Double, Never> {
    nonmutating set {
      let prop: MutableProperty<Double> = lazyMutableProperty(
        object, key: &Associations.minimumValue,
        setter: { [weak object] in object?.minimumValue = $0 },
        getter: { [weak object] in object?.minimumValue ?? 0.0 })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }

  var stepValue: Signal<Double, Never> {
    nonmutating set {
      let prop: MutableProperty<Double> = lazyMutableProperty(
        object, key: &Associations.stepValue,
        setter: { [weak object] in object?.stepValue = ($0 > 0 ? $0 : 1.0 ) },
        getter: { [weak object] in object?.stepValue ?? 1.0 })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }

  var value: Signal<Double, Never> {
    nonmutating set {
      let prop: MutableProperty<Double> = lazyMutableProperty(
        object, key: &Associations.value,
        setter: { [weak object] in object?.value = $0 },
        getter: { [weak object] in object?.value ?? 0.0 })

      prop <~ newValue.observeForUI()
    }
    get {
      return .empty
    }
  }
}
