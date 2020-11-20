//
//  QueueRingBuffer.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation

struct QueueRingBuffer<T>: Queue {
    typealias Element = T
    
    private var ringBuffer: RingBuffer<T>
    
    init(count: Int){
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    var peek: T? {
        ringBuffer.first
    }
}
