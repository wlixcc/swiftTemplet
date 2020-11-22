//
//  AVLTree.swift
//  Templet
//
//  Created by wl on 2020/11/22.
//

import Foundation

public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() {}
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

extension AVLTree {
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        //进行平衡
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        
        return balancedNode
    }
    
    private func balanced(_ node: AVLNode<Element>)
    -> AVLNode<Element> {
        
        switch node.balanceFactor {
        case 2:
        // 左子树 > 右子树
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
        // 右子树 > 左子树
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        
        default:
            return node
        }
    }
    
    // 右子树>左子树的时候进行 左旋转
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        //1 把右子节点做为新树的root,右树上升一级
        let pivot = node.rightChild!
        //2 把pivot的左节点作为node的右节点。 根据二叉搜索树的原理， pivot.leftChild.value必定 > node.value
        node.rightChild = pivot.leftChild
        //3 移动node做为新树的左节点
        pivot.leftChild = node
        //4
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    // 左子树>右子树的时候进行 右旋转
    private func rightRotate(_ node: AVLNode<Element>)
    -> AVLNode<Element> {
        
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>)
    -> AVLNode<Element> {
        
        guard let rightChild = node.rightChild else {
            return node
        }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>)
    -> AVLNode<Element> {
        
        guard let leftChild = node.leftChild else {
            return node
        }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
}

extension AVLTree {
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

private extension AVLNode {
    
    var min: AVLNode {
        leftChild?.min ?? self
    }
}

extension AVLTree {
    
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

