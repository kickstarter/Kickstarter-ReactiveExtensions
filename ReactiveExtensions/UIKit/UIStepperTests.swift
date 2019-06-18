import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UIStepperTests: XCTestCase {
  let uiStepper = UIStepper(frame: .zero)

  func testValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.value = signal

    eventually(XCTAssertEqual(0, self.uiStepper.value))

    observer.send(value: 10)
    eventually(XCTAssertEqual(10, self.uiStepper.value))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.value))
  }

  func testMinimumValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.minimumValue = signal

    eventually(XCTAssertEqual(0, self.uiStepper.minimumValue))

    observer.send(value: 10)
    eventually(XCTAssertEqual(10, self.uiStepper.minimumValue))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.minimumValue))
  }

  func testMaximumValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.maximumValue = signal

    eventually(XCTAssertEqual(100, self.uiStepper.maximumValue))

    observer.send(value: 10)
    eventually(XCTAssertEqual(10, self.uiStepper.maximumValue))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.maximumValue))
  }
}
