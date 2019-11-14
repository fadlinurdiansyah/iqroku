//
//  JuzAmmaDetailCell.swift
//  iQroku
//
//  Created by NDS on 11/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class JuzAmmaDetailCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
