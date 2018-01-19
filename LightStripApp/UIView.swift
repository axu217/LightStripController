//
//  UIView.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/07.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradient(colorOne: UIColor, colorTwo: UIColor) {
        let gLayer = CAGradientLayer()
        gLayer.frame = bounds
        gLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gLayer.locations = [0.0, 1.0]
        gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(gLayer, at: 0)
    }
}
