//
//  QueueLinkedList.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation

class QueueLinkedList<T>: Queue {
    
    typealias Element = T
        
    private var list = DoublyLinkedList<T>()
    
    init() {}
    
    func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
    
    var isEmpty: Bool {
        list.isEmpty
    }
    
    var peek: T? {
        list.first?.value
    }
    
}

extension QueueLinkedList: CustomStringConvertible {
   var description: String {
    String(describing: list)
  }
}
