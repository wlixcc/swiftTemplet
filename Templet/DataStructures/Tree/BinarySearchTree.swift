//
//  BinarySearchTree.swift
//  Templet
//
//  Created by wl on 2020/11/21.
//

import Foundation


/// 二叉搜索树2个规则：1.左节点必须小于根节点  2.右节点必须大于等于根节点
public struct BinarySearchTree<Element: Comparable> {
    private(set) var root: BinaryNode<Element>?
    init(){}
}

extension BinarySearchTree {
    mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node:BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else {
            return BinaryNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

extension BinarySearchTree {
    func contain(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            // 小于节点搜索左子树，大于搜索右子树
            current = value < node.value ? node.leftChild : node.rightChild
        }
        return false
    }
}

// MAKR: Remove
private extension BinaryNode {
    var min: BinaryNode {
        leftChild?.min ?? self
    }
}
extension BinarySearchTree {
    //case1: 叶节点可以直接移除
    //case2: 如果只有一个子节点, 需要把子节点接到父父节点上
    //case3: 如果节点有两个子节点,移除后需要把右子树上最小的节点移动到当前节点上(右节点上即使最小的值也会比左节点的大,二叉搜索树的基本原则)
    
    mutating func remove(_ value: Element) {
      root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element>? {
        guard let node = node else {
            return nil
        }
        if node.value == value {
            // case1
            if node.leftChild == nil && node.rightChild == nil {
                // 移除此节点
                return  nil
            }
            // case2
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            
            // case3
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        return node
    }
    
}

extension BinarySearchTree: Equatable {

  // 1
  public static func ==(lhs: BinarySearchTree,
                        rhs: BinarySearchTree) -> Bool {
    isEqual(lhs.root, rhs.root)
  }

  // 2
  private static func isEqual<Element: Equatable>(
    _ node1: BinaryNode<Element>?,
    _ node2: BinaryNode<Element>?) -> Bool {
     
  // 3
  guard let leftNode = node1,
        let rightNode = node2 else {
    return node1 == nil && node2 == nil
  }
  
  // 4
  return leftNode.value == rightNode.value &&
    isEqual(leftNode.leftChild, rightNode.leftChild) &&
    isEqual(leftNode.rightChild, rightNode.rightChild)
  }
}

extension BinarySearchTree where Element: Hashable {

  public func contains(_ subtree: BinarySearchTree) -> Bool {
  
    // 2
    var set: Set<Element> = []
    root?.traverseInOrder {
      set.insert($0)
    }
    
    // 3
    var isEqual = true

    // 4
    subtree.root?.traverseInOrder {
      isEqual = isEqual && set.contains($0)
    }
    return isEqual
  }
}

extension BinarySearchTree: CustomStringConvertible {

  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}
