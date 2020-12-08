//
//  SelectionSort.swift
//  Templet
//
//  Created by wl on 2020/11/26.
//

import Foundation

/// 每一次选择出最小的元素放在前面,比冒泡排序性能好,交换的次数少
public func selectionSort<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
    guard collection.count >= 2 else {
        return
    }
    for current in collection.indices {
        var lowest = current
        var other = collection.index(after: current)
        while other < collection.endIndex {
            if collection[lowest] > collection[other] {
                lowest = other
            }
            other = collection.index(after: other)
        }
        if lowest != current {
            collection.swapAt(lowest, current)
        }
    }
}
