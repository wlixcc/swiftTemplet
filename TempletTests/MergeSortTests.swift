//
//  MergeSortTests.swift
//  TempletTests
//
//  Created by wl on 2020/11/26.
//

import XCTest
@testable import Templet


class MergeSortTests: XCTestCase {

    func testSort()  {
        example(of: "merge sort") {
          let array = [7, 2, 6, 3, 9]
          print("Original: \(array)")
          print("Merge sorted: \(mergeSort(array))")
        }
    }

}
