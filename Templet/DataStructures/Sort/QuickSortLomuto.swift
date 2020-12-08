//
//  QuickSortLomuto.swift
//  Templet
//
//  Created by wl on 2020/12/8.
//

import Foundation

/// Lomuto’s partitioning总是选择最后一个元素作为锚点
/// - Parameters:
///   - a: 数组
///   - low: range
///   - high: range
/// - Returns: index of pivot
public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    //选择最后一个元素作为pivot
    let pivot = a[high]
    
    //用于记录有多少个元素小于pivot,做对比的时候,把所有小于pivot的元素移动到前面。 等循环完成后把交换pivot和i的位置
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    a.swapAt(i, high)
    return i
}

public func quicksortLomuto<T: Comparable>(_ a: inout [T],
                                           low: Int, high: Int) {
  if low < high {
    let pivot = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: pivot - 1)
    quicksortLomuto(&a, low: pivot + 1, high: high)
  }
}
