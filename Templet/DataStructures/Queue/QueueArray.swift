//
//  QueueArray.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation

 struct QueueArray<T>: Queue {
    typealias Element = T
    
    private var array: [T] = []
     init(){}
    
    @discardableResult
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var peek: T? {
        array.first
    }
    
}

extension QueueArray: CustomStringConvertible {
   var description: String {
    String(describing: array)
  }
}
