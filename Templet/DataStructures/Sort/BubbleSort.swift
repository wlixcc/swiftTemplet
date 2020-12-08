//
//  BubbleSort.swift
//  Templet
//
//  Created by wl on 2020/11/26.
//

import Foundation


/// 每一次操作将最大的值冒泡到末尾
public func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
    // 1
    guard array.count >= 2 else {
        return
    }
    // 2
    for end in (1..<array.count).reversed() {
        var swapped = false
        // 3
        for current in 0..<end {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        // 4 已排序,提前终止
        if !swapped {
            return
        }
    }
}
