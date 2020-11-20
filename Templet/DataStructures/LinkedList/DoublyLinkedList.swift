//
//  DoublyLinkedList.swift
//  Templet
//
//  Created by wl on 2020/11/20.
//

import Foundation

class DoublyLinkedList<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    init() { }
    
    var isEmpty: Bool {
        head == nil
    }
    
    var first: Node<T>? {
        head
    }
    
    func append(_ value: T) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    func remove(_ node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    
    var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + "end"
    }
}

class LinkedListIterator<T>: IteratorProtocol {
    
    private var current: Node<T>?
    
    init(node: Node<T>?) {
        current = node
    }
    
    func next() -> Node<T>? {
        defer { current = current?.next }
        return current
    }
}

extension DoublyLinkedList: Sequence {
    
    func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(node: head)
    }
}

