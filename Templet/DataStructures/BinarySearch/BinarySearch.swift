//
//  BinarySearch.swift
//  Templet
//
//  Created by wl on 2020/11/23.
//

import Foundation

/// 二叉搜索仅能用于已排序的集合中
public extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        
        // 1
        let range = range ?? startIndex..<endIndex
        // 2
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        //3
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        
        //4
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
    }
    
    func binarySearch<Elements: RandomAccessCollection>(
        for element: Elements.Element,
        in collection: Elements,
        in range: Range<Elements.Index>? = nil) -> Elements.Index?
    where Elements.Element: Comparable {
        
        let range = range ?? collection.startIndex..<collection.endIndex
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        let size = collection.distance(from: range.lowerBound,
                                       to: range.upperBound)
        let middle = collection.index(range.lowerBound, offsetBy: size / 2)
        if collection[middle] == element {
            return middle
        } else if collection[middle] > element {
            return binarySearch(for: element, in: collection, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: element,
                                in: collection,
                                in: collection.index(after: middle)..<range.upperBound)
        }
    }
    
}
