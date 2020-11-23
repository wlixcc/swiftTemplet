//
//  TrieNode.swift
//  Templet
//
//  Created by wl on 2020/11/23.
//

import Foundation

public class TrieNode<Key: Hashable> {
    // key holds the data for the node. This is optional because the root node of the trie has no key
    public var key: Key?
    
    public weak var parent: TrieNode?
    
    public var children: [Key: TrieNode] = [:]
    
    // 标明是否是结尾
    public var isTerminating = false
    
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
