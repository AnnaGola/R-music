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
}
