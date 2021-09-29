//
//  .swift
//  Cooker
//
//  Created by wl on 2020/3/13.
//  Copyright © 2020 hzjuzhi. All rights reserved.
//

import UIKit

/// https://material.io/design/color/the-color-system.html#
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: (CGFloat(hex >> 16 & 0xff) / 255), green: (CGFloat(hex >> 8 & 0xff) / 255), blue: (CGFloat(hex & 0xff) / 255), alpha: alpha)
    }
    
    static func colorWithHex(_ hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: (CGFloat(hexValue >> 16 & 0xff) / 255), green: (CGFloat(hexValue >> 8 & 0xff) / 255), blue: (CGFloat(hexValue & 0xff) / 255), alpha: alpha)
    }
}
