//
//  LinkedList.swift
//  Templet
//
//  Created by wl on 2020/11/19.
//

import Foundation

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init(){}
    
    var isEmpty: Bool {
        head == nil
    }
    
    mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    //https://stackoverflow.com/questions/42513032/whats-the-difference-between-a-defer-statement-and-a-statement-right-just-befor
    @discardableResult
    mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    @discardableResult
    mutating func removeLast() -> Value? {
        copyNodes()
        //1 nothing to remove
        guard let head = head else {
            return nil
        }
        //2
        guard head.next != nil else {
            return pop()
        }
        
        //3
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        
        //4
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    mutating func remove(after node: Node<Value>) -> Value? {
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    
    func node(at index: Int) -> Node<Value>? {
        //1
        var currentNode = head
        var currentIndex = 0
        
        //2
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    // copy on write
    @discardableResult
    private mutating func copyNodes(returningCopyOf node: Node<Value>? = nil) -> Node<Value>? {
        //如果有多个引用,则进行copy
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        guard var oldNode = head else {
            return nil
        }
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<Value>?

        while let nextOldNode = oldNode.next {
            if oldNode === node {
              nodeCopy = newNode
            }
            newNode?.next = Node(value: nextOldNode.value)
            newNode = newNode?.next
            oldNode = nextOldNode
        }
        tail = newNode
        
        return nodeCopy
    }
}

extension LinkedList: Collection {
    func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    subscript(position: Index) -> Value {
        position.node!.value
    }
    
    var startIndex: Index {
        Index(node: head)
    }
    
    // endIndex为可访问元素的后一个
    var endIndex: Index {
        Index(node: tail?.next)
    }
    
    struct Index: Comparable {
         var node: Node<Value>?

        
        static func < (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            //获取了lhs.node到tail的所有节点,如果节点包含rhs.node说明 < 成立
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains{$0 === rhs.node}
        }
        
        static func == (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        
        
        
    }
    
}

extension LinkedList: CustomStringConvertible {

   var description: String {
    guard let head = head else {
      return "Empty list"
    }
    return String(describing: head)
  }
}
