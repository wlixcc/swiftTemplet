//
//  QuickSort.swift
//  Templet
//
//  Created by wl on 2020/12/4.
//

import Foundation


/// 这个快排很好理解,但是时间和空间复杂度都是很差的， 并且选择中间的元素作为pivot不一定是最好的
public func quicksortNaive<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else {
        return a
    }
    
    //Pick the middle element of the array as your pivot
    let pivot = a[a.count/2]
    let less = a.filter{$0 < pivot}
    let equal = a.filter{$0 == pivot}
    let greater = a.filter {$0 > pivot}
    
    return quicksortNaive(less) + equal + quicksortNaive(greater)
}


