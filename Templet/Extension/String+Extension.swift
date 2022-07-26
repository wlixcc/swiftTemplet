//
//  String+Extension.swift
//  Yinhe
//
//  Created by wl on 2021/9/6.
//

import Foundation
import UIKit


extension String {
    func addAttributes(to string: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        return attributeString.addAttributes(to: string, attributes: attributes)
    }

    func withLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        return attributeString.withLineSpacing(spacing)
    }
}

extension NSAttributedString {
    // 可以不断添加attributes,重复调用不会丢失已添加的attributes
    func addAttributes(to string: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(attributedString: self)
        var range = (self.string as NSString).range(of: string)
        
        // 找字符串中所有匹配到的range
        while range.location != NSNotFound {
            attributeString.addAttributes(attributes, range: range)
            let newLocation = range.location + range.length
            // 这里使用utf16 count 支持emoji
            range = (self.string as NSString).range(of: string, range: .init(location: newLocation, length: self.string.utf16.count - newLocation))
        }
        return attributeString
    }
    
    func withLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = spacing
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        // 这里使用utf16 count 支持emoji
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: .init(location: 0, length: self.string.utf16.count))
        return attributedString
    }
}
