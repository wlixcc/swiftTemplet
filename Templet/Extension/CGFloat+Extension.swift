//
//  CGFloat+Extension.swift
//  Templet
//
//  Created by wl on 2021/5/26.
//

import UIKit

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static let bottomPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    
}
