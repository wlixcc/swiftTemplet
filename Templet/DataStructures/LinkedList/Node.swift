//
//  Node.swift
//  Templet
//
//  Created by wl on 2020/11/19.
//

import Foundation

 class Node<Value> {
     var value: Value
     var next: Node?
     var previous: Node<Value>?

    
     init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
}

extension Node: CustomStringConvertible {

   var description: String {
    guard let next = next else {
      return "\(value)"
    }
    return "\(value) -> " + String(describing: next) + " "
  }
}
