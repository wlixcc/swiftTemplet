//
//  BinaryNode.swift
//  Templet
//
//  Created by wl on 2020/11/21.
//

import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

// MARK: 遍历
extension BinaryNode {
    // 中序遍历。 左-根-右
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    // 先序遍历。 根-左-右
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    // 后续遍历。 左-右-根
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode {
    var height: Int {
        return 1 + max(self.leftChild?.height ?? -1, self.rightChild?.height ?? -1)
    }
}

// 判断二叉树是不是二叉搜索树
extension BinaryNode where Element: Comparable {
    
    var isBinarySearchTree: Bool {
        isBST(self, min: nil, max: nil)
    }
    
    // 1
    private func isBST(_ tree: BinaryNode<Element>?,
                       min: Element?,
                       max: Element?) -> Bool {
        // 2
        guard let tree = tree else {
            return true
        }
        // 3
        if let min = min, tree.value <= min {
            return false
        } else if let max = max, tree.value > max {
            return false
        }
        
        // 4
        return isBST(tree.leftChild, min: min, max: tree.value) &&
            isBST(tree.rightChild, min: tree.value, max: max)
    }
}

extension BinaryNode: CustomStringConvertible {
    
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild,
                      bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

