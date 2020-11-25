//
//  Heap.swift
//  Templet
//
//  Created by wl on 2020/11/23.
//

import Foundation

/// Heap is a complete binary tree ,不要和内存中的堆搞混(不是同一个概念)
/// A complete binary tree is a binary tree in which every level, except possibly the last, is completely filled, and all nodes are as far left as possible
/// Max Heap  父节点>=子节点 根节点最大。 Min Heap 父节点<=子节点,根节点最小
struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool

    init(sort: @escaping (Element, Element) -> Bool,
         elements: [Element] = []) {
      self.sort = sort
      self.elements = elements
      
      if !elements.isEmpty {
        for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
          siftDown(from: i)
        }
      }
    }
    
    var isEmpty: Bool {
      elements.isEmpty
    }

    var count: Int {
      elements.count
    }

    func peek() -> Element? {
      elements.first
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
      (2 * index) + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
      (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
      (index - 1) / 2
    }
    
    mutating func remove() -> Element? {
      guard !isEmpty else { // 1
        return nil
      }
      elements.swapAt(0, count - 1) // 2
      defer {
        siftDown(from: 0) // 4
      }
      return elements.removeLast() // 3
    }
    
    mutating func siftDown(from index: Int) {
      var parent = index // 1
      while true { // 2
        let left = leftChildIndex(ofParentAt: parent) // 3
        let right = rightChildIndex(ofParentAt: parent)
        var candidate = parent // 4
        if left < count && sort(elements[left], elements[candidate]) {
          candidate = left // 5
        }
        if right < count && sort(elements[right], elements[candidate]) {
          candidate = right // 6
        }
        if candidate == parent {
          return // 7
        }
        elements.swapAt(parent, candidate) // 8
        parent = candidate
      }
    }
    
    mutating func insert(_ element: Element) {
      elements.append(element)
      siftUp(from: elements.count - 1)
    }

    mutating func siftUp(from index: Int) {
      var child = index
      var parent = parentIndex(ofChildAt: child)
      while child > 0 && sort(elements[child], elements[parent]) {
        elements.swapAt(child, parent)
        child = parent
        parent = parentIndex(ofChildAt: child)
      }
    }
    
    mutating func remove(at index: Int) -> Element? {
      guard index < elements.count else {
        return nil // 1
      }
      if index == elements.count - 1 {
        return elements.removeLast() // 2
      } else {
        elements.swapAt(index, elements.count - 1) // 3
        defer {
          siftDown(from: index) // 5
          siftUp(from: index)
        }
        return elements.removeLast() // 4
      }
    }
    
    func index(of element: Element, startingAt i: Int) -> Int? {
      if i >= count {
        return nil // 1
      }
      if sort(element, elements[i]) {
        return nil // 2
      }
      if element == elements[i] {
        return i // 3
      }
      if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
        return j // 4
      }
      if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
        return j // 5
      }
      return nil // 6
    }
}
    
