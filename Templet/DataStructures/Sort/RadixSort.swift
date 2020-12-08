//
//  RadixSort.swift
//  Templet
//
//  Created by wl on 2020/11/27.
//

import Foundation


extension Array where Element == Int {
    
    public mutating func radixSort() {
        
        //1 10进制
        let base = 10
        //2 表明排序是否结束
        var done = false
        //3 用于记录当前位 个位/十位/百位
        var digits = 1
        
        while !done {
            done = true
            var buckets: [[Int]] = .init(repeating: [], count: base)
            // extension Array ,对数组元素forEach
            forEach { number in
                let remainingPart = number / digits
                let digit = remainingPart % base
                buckets[digit].append(number)
                if remainingPart > 0 {
                    done = false
                }
            }
            digits *= base
            print(buckets)
            self = buckets.flatMap { $0 }
        }
    }
}
