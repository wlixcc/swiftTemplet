//
//  Queue.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation


protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
