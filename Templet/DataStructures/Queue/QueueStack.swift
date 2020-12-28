//
//  QueueStack.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation

public struct QueueStack<T>: Queue {
    typealias Element = T
    
    // 出队列把所有元素从rightStack放置到leftStack
    private var leftStack: [T] = []
    // 入队列元素放到rightStack
    private var rightStack: [T] = []
    
    init() {}
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        if leftStack.isEmpty { // 1
            leftStack = rightStack.reversed() // 2
            rightStack.removeAll() // 3
        }
        return leftStack.popLast() // 4”
    }
    
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? {
        leftStack.isEmpty ? leftStack.first : rightStack.last
    }
    
    
}
