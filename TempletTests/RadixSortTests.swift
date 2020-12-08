//
//  RadixSortTests.swift
//  TempletTests
//
//  Created by wl on 2020/11/27.
//

import XCTest
@testable import Templet


class RadixSortTests: XCTestCase {

    func testSort() {
        example(of: "radix sort") {
          var array = [88, 410, 1772, 20, 1, 7]
          print("Original array: \(array)")
          array.radixSort()
          print("Radix sorted: \(array)")
        }
    }

}
