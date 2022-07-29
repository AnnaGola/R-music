//
//  UIImageView + Blur.swift
//  R • music
//
//  Created by anna on 29.07.2022.
//

import UIKit

extension UIImageView {
    func blurBackgroung(style: UIBlurEffect.Style) {
           let blurEffect = UIBlurEffect(style: style)
           let blurView = UIVisualEffectView(effect: blurEffect)
           blurView.frame = self.frame
           blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.addSubview(blurView)
           self.sendSubviewToBack(blurView)
       }
}
