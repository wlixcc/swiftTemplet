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
    static let displayTime = 3.0
    
    static func showImage(imageName: String) -> MBProgressHUD {
        guard let view = UIApplication.shared.windows.first else {
            return MBProgressHUD()
        }
        MBProgressHUD.hide(for: view, animated: false)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView
        hud.isUserInteractionEnabled = false
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        hud.customView = UIImageView(image: image)
        hud.offset = CGPoint(x: 0, y: -80)
        return hud
    }
    
    static func showError(message: String) {
         let hud = showImage(imageName: "hud_error")
         hud.label.text = message
         hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
     }
     
    static func showSuccess(message: String) {
         let hud = showImage(imageName: "hud_success")
         hud.label.text = message
         hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
     }
     
    static func showMessage(message: String) {
        guard let view = UIApplication.shared.windows.first else {
            return 
        }
         MBProgressHUD.hide(for: view, animated: false)
         let hud = MBProgressHUD.showAdded(to: view, animated: true)
         hud.removeFromSuperViewOnHide = true
         hud.isUserInteractionEnabled = false
         hud.mode = .text
         hud.label.text = message
         hud.offset = CGPoint(x: 0, y: -80)
         hud.hide(animated: true, afterDelay: MBProgressHUD.displayTime)
     }
    
    func setCustomView(_ customView: UIView, perferSize size: CGSize) {
        mode = .customView
        let contentView = HUDCustomContentView(perferSize: size)
        contentView.addSubview(customView)
        customView.frame = CGRect(x: 0, y: 0, width: contentView.intrinsicContentSize.width, height: contentView.intrinsicContentSize.height)
        self.customView = contentView
    }
}

class HUDCustomContentView: UIView {
    let perferSize: CGSize
    init(perferSize: CGSize) {
        self.perferSize = perferSize
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override var intrinsicContentSize: CGSize {
        return self.perferSize
    }
    
}
