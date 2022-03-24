//
//  MBProgressHUD+Extension.swift
//  Cooker
//
//  Created by 王利 on 2020/3/21.
//  Copyright © 2020 hzjuzhi. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    static var displayTime = 3.0
    
    static func show(image: UIImage?) -> MBProgressHUD {
        guard let view = getKeyWindow() else {
            return MBProgressHUD()
        }
        MBProgressHUD.hide(for: view, animated: false)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView
        hud.isUserInteractionEnabled = false
        hud.customView = UIImageView(image: image)
        hud.offset = CGPoint(x: 0, y: -80)
        return hud
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    static func show(error message: String) -> MBProgressHUD {
        let hud = show(image: UIImage(systemName: "xmark"))
        hud.label.text = message
        hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
        return hud
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    static func show(success message: String) -> MBProgressHUD {
        let hud = show(image: UIImage(systemName: "checkmark"))
        hud.label.text =  message
        hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
        return hud
    }
    
    @discardableResult
    static func show(message: String) -> MBProgressHUD {
        guard let view = getKeyWindow() else {
            return  MBProgressHUD()
        }
        MBProgressHUD.hide(for: view, animated: false)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.numberOfLines = 0
        hud.label.text = message
        hud.offset = CGPoint(x: 0, y: -80)
        hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
        return hud
    }
    
    func setCustomView(_ customView: UIView, preferSize size: CGSize) {
        mode = .customView
        let contentView = HUDCustomContentView(preferSize: size)
        contentView.addSubview(customView)
        customView.frame = CGRect(x: 0, y: 0, width: contentView.intrinsicContentSize.width, height: contentView.intrinsicContentSize.height)
        self.customView = contentView
    }
    
    /// 使用了PIPController之后,会有PGHostedWindow
    private static func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.windows.first(where: {$0.isKeyWindow})
    }
}

class HUDCustomContentView: UIView {
    let preferSize: CGSize
    init(preferSize: CGSize) {
        self.preferSize = preferSize
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override var intrinsicContentSize: CGSize {
        return self.preferSize
    }
}
