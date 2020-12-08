//
//  QuickSortTests.swift
//  TempletTests
//
//  Created by wl on 2020/12/4.
//

import XCTest
@testable import Templet


class QuickSortTests: XCTestCase {

    func testLomuto() {
        var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
        quicksortLomuto(&list, low: 0, high: list.count - 1)
        print(list)
    }
    
    func testHoare() {
        var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
        quicksortHoare(&list2, low: 0, high: list2.count - 1)
        print(list2)
    }
    
    func testMeidan() {
        var list3 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
        quickSortMedian(&list3, low: 0, high: list3.count - 1)
        print(list3)
    }

}
