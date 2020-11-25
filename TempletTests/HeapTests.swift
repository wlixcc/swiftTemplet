//
//  HeapTests.swift
//  TempletTests
//
//  Created by wl on 2020/11/24.
//

import XCTest
@testable import Templet


class HeapTests: XCTestCase {

    func testRemove() {
        var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])

        while !heap.isEmpty {
          print(heap.remove()!)
        }
    }

}
