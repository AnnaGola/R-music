//
//  UIView extension.swift
//  R • music
//
//  Created by anna on 27.07.2022.
//

import UIKit

extension UIView {
    class func loadSongPlayer<T: UIView>() -> T {
     return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func addLayer(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addRadius(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }
}

