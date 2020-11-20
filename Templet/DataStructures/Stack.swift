//
//  Stack.swift
//  Templet
//
//  Created by wl on 2020/11/18.
//

import Foundation

struct Stack<Element> {
    private var storage: [Element] = []
    
    var isEmpty: Bool {
        storage.isEmpty
    }
    
     init() {}
    
     init(_ elements: [Element]) {
        storage = elements
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult mutating func pop() -> Element? {
        storage.popLast()
    }
    
    func peek() -> Element? {
        storage.last
    }
}

extension Stack: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = Element
    
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
    }
}
