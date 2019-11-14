//
//  IqroCell.swift
//  iQroku
//
//  Created by NDS on 04/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class IqroCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTotalPage: UILabel!
    var data: IqroPage?
    
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
        if let number = data?.number,
            let totalPage = data?.page {
            labelTitle.text = "IQRO 0\(number)"
            labelTotalPage.text = "Total Halaman \(totalPage)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
