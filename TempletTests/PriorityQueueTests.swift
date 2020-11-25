//
//  PirorityQueueTests.swift
//  TempletTests
//
//  Created by wl on 2020/11/25.
//

import XCTest
@testable import Templet

class PriorityQueueTests: XCTestCase {

    func testDequeue() {
        var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7])
        while !priorityQueue.isEmpty {
          print(priorityQueue.dequeue()!)
        }
    }

}
