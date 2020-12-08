//
//  QuicksortHoare.swift
//  Templet
//
//  Created by wl on 2020/12/8.
//

import Foundation


/// Hoare总是选择第一个元素作为锚点
/// - Parameters:
///   - a: array
///   - low: low
///   - high: high
/// - Returns: Index
public func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    //所有小于i的index都需要在小于等于pivot
    var i = low - 1
    //所有大于j的index都需要大于等于pivot
    var j = high + 1
    
    while true {
        repeat {j -= 1} while a[j] > pivot
        repeat {i += 1} while a[i] < pivot
        
        if i < j {
            a.swapAt(i, j)
        }  else {
            return j
        }
    }
}

public func quicksortHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) {
  if low < high {
    let p = partitionHoare(&a, low: low, high: high)
    quicksortHoare(&a, low: low, high: p)
    quicksortHoare(&a, low: p + 1, high: high)
  }
}
