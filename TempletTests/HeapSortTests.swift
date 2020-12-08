//
//  HeapSortTests.swift
//  TempletTests
//
//  Created by wl on 2020/12/3.
//

import XCTest
@testable import Templet


class HeapSortTests: XCTestCase {

    func testSort()  {
        let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
        print(heap)
        print(heap.sorted())
    }

}
