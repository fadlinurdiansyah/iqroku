//
//  IqroDetailCell.swift
//  iQroku
//
//  Created by NDS on 09/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class IqroDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIqro: UIImageView!
    var data: Iqro?
    
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
        if let imgNumber  = data?.rowid {
        imgIqro.image = UIImage(named: "img-iqro-\(imgNumber)")
        }
        
    }
    

}
