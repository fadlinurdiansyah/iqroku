//
//  ColourConstants.swift
//  iQroku
//
//  Created by NDS on 24/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

struct ColourConstant {
    
    static let paleViolet = UIColor(hex: 0xC2B4F7)
    static let greyishBrown = UIColor(hex: 0x4B4A4A)
    static let buff = UIColor(hex: 0xF7F8A4)
    static let grapefruit = UIColor(hex: 0xF65D5D)
    static let lightOliveGreen = UIColor(hex: 0xA8C23F)
    static let lightGrey = UIColor(hex: 0xD3D6C6)
    
}

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x0000FF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
