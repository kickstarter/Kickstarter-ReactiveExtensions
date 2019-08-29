import XCTest
import ReactiveSwift
import ReactiveExtensions
import UIKit
@testable import ReactiveExtensions_TestHelpers

final class UITableViewCellTests: XCTestCase {
  let cell = UITableViewCell(frame: .zero)

  func testAccessoryType() {
    let (signal, observer) = Signal<UITableViewCell.AccessoryType, Never>.pipe()
    cell.rac.accessoryType = signal

    observer.send(value: .none)
    eventually(XCTAssertEqual(.none, self.cell.accessoryType))

    observer.send(value: .disclosureIndicator)
    eventually(XCTAssertEqual(.disclosureIndicator, self.cell.accessoryType))

    observer.send(value: .detailDisclosureButton)
    eventually(XCTAssertEqual(.detailDisclosureButton, self.cell.accessoryType))

    observer.send(value: .checkmark)
    eventually(XCTAssertEqual(.checkmark, self.cell.accessoryType))

    observer.send(value: .detailButton)
    eventually(XCTAssertEqual(.detailButton, self.cell.accessoryType))
  }
}
