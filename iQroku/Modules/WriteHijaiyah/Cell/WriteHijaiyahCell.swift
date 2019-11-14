//
//  WriteHijaiyahCell.swift
//  iQroku
//
//  Created by NDS on 13/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class WriteHijaiyahCell: UICollectionViewCell {
    
    var index: Int = 0
    @IBOutlet weak var imageViewHijaiyah: UIImageView!
    
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
    
    func updateUI() {
        imageViewHijaiyah.image = UIImage(named: "img-hijaiyah-\(index)")
    }

}
