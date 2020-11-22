//
//  TempletTests.swift
//  TempletTests
//
//  Created by wl on 2020/11/20.
//

import XCTest
@testable import Templet

class TempletTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTreeNode() {
        example(of: "tree diagram") {
            print(makeBinaryTree())
            print(makeBinaryTree().height)
        }
    }
    
    func testBinarySearchTreeInsert() {
        example(of: "building a BST") {
            var bst = BinarySearchTree<Int>()
            for i in 0..<5 {
                bst.insert(i)
            }
            print(bst)
        }
    }
    
    func testBinarySearchTreeRemove() {
        example(of: "remove") {
            var bst = BinarySearchTree<Int>()
            for i in 0..<5 {
                bst.insert(i)
            }
            
            print("Tree before removal:")
            print(bst)
            bst.remove(0)
            print("Tree after removing root:")
            print(bst)
        }
    }
    
    func testAVLTreeInsert() {
        example(of: "repeated insertions in sequence") {
            var tree = AVLTree<Int>()
            for i in 0..<15 {
                tree.insert(i)
            }
            print(tree)
            assert(tree.root!.balanceFactor >= -1 && tree.root!.balanceFactor <= 1)
        }
    }
    
    func testAVLTreeRemove() {
        example(of: "removing a value") {
          var tree = AVLTree<Int>()
          tree.insert(15)
          tree.insert(10)
          tree.insert(16)
          tree.insert(18)
          print(tree)
          tree.remove(10)
          print(tree)
          assert(tree.root!.balanceFactor >= -1 && tree.root!.balanceFactor <= 1)
        }
    }
    
    func makeBinaryTree() -> BinaryNode<Int> {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)
        
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight
        
        return seven
    }
    
    
    func makeBeverageTree() -> TreeNode<String> {
        let tree = TreeNode("Beverages")
        
        let hot = TreeNode("hot")
        let cold = TreeNode("cold")
        
        let tea = TreeNode("tea")
        let coffee = TreeNode("coffee")
        let chocolate = TreeNode("cocoa")
        
        let blackTea = TreeNode("black")
        let greenTea = TreeNode("green")
        let chaiTea = TreeNode("chai")
        
        let soda = TreeNode("soda")
        let milk = TreeNode("milk")
        
        let gingerAle = TreeNode("ginger ale")
        let bitterLemon = TreeNode("bitter lemon")
        
        tree.add(hot)
        tree.add(cold)
        
        hot.add(tea)
        hot.add(coffee)
        hot.add(chocolate)
        
        cold.add(soda)
        cold.add(milk)
        
        tea.add(blackTea)
        tea.add(greenTea)
        tea.add(chaiTea)
        soda.add(gingerAle)
        soda.add(bitterLemon)
        
        return tree
    }
    
}
