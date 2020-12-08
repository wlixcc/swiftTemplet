//
//  InsertionSort.swift
//  Templet
//
//  Created by wl on 2020/11/26.
//

import Foundation

/// The Swift standard library sort algorithm uses a hybrid of sorting approaches with insertion sort being used for small (<20 element) unsorted partitions.
/// 插入排序如果元素已经排序的元素越多,耗时越短。 核心思想  假设n-1个数已排序好，将n个数插入这个排序好的序列中
public func insertionSort<T>(_ collection: inout T) where T: BidirectionalCollection & MutableCollection,
      T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    for current in collection.indices {
        var shifting = current
        while shifting > collection.startIndex {
            let previous = collection.index(before: shifting)
            if collection[shifting] < collection[previous] {
                collection.swapAt(shifting, previous)
            } else {
                break
            }
            shifting = previous
        }
    }
}
