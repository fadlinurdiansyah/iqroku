//
//  UIView+Draw.swift
//  iQroku
//
//  Created by NDS on 16/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
}
