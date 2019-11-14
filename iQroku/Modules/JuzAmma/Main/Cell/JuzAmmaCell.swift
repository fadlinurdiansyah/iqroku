//
//  JuzAmmaCell.swift
//  iQroku
//
//  Created by NDS on 09/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class JuzAmmaCell: UITableViewCell {
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
