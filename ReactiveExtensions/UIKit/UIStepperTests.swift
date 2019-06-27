import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

internal final class UIStepperTests: XCTestCase {
  let uiStepper = UIStepper(frame: .zero)

  func testMaximumValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.maximumValue = signal

    eventually(XCTAssertEqual(100, self.uiStepper.maximumValue))

    observer.send(value: 10)
    eventually(XCTAssertEqual(10, self.uiStepper.maximumValue))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.maximumValue))
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

  func testStepValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.stepValue = signal

    eventually(XCTAssertEqual(1, self.uiStepper.stepValue))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.stepValue))

    observer.send(value: 0)
    eventually(XCTAssertEqual(1, self.uiStepper.stepValue))

    observer.send(value: -1)
    eventually(XCTAssertEqual(1, self.uiStepper.stepValue))
  }

  func testValue() {
    let (signal, observer) = Signal<Double, Never>.pipe()
    uiStepper.rac.value = signal

    eventually(XCTAssertEqual(0, self.uiStepper.value))

    observer.send(value: 10)
    eventually(XCTAssertEqual(10, self.uiStepper.value))

    observer.send(value: 20)
    eventually(XCTAssertEqual(20, self.uiStepper.value))
  }
}
