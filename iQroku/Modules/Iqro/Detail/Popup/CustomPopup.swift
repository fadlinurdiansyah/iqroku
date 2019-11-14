//
//  CustomPopup.swift
//  iQroku
//
//  Created by NDS on 05/10/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

protocol CustomPopupDelegate: class {
    func goToPage()
    func dismissPopUp()
}

class CustomPopup: UIView {
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var btnNextPage: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    weak var delegate: CustomPopupDelegate?
    var completePage: Int = 0
    var totalPage: Int = 0
    var iqroNumber: Int = 0
    let textGoto = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_desc_goto", comment: "")
    let textComplete = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_desc_complete", comment: "")
    let textBtnNext = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_btn_next_page", comment: "")
    let textBtnClose = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_btn_close", comment: "")
    let textBtnCancel = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_btn_cancel", comment: "")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        delegate?.dismissPopUp()
    }
    
    @IBAction func btnNextPageTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            
            delegate?.dismissPopUp()
        } else if sender.tag == 1 {
            
            delegate?.goToPage()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        fromNib()
        clipsToBounds = true
        layer.cornerRadius = 25
    }
    
    func setupPopup() {
        print("complete \(completePage) total \(totalPage)")
        print("\(textBtnClose)")
        if completePage == totalPage {
            
            // Dismiss popup
            labelDescription.text = "\(textComplete) \(iqroNumber)"
            btnNextPage.setTitle("\(textBtnClose)", for: UIControl.State.normal)
            btnNextPage.tag = 0
            btnCancel.isHidden = true
            
        } else if completePage != totalPage {
            
            // Goto next page
            labelDescription.text = "\(textGoto) \(completePage)"
            btnNextPage.setTitle("\(textBtnNext)", for: UIControl.State.normal)
            btnNextPage.tag = 1
            btnCancel.isHidden = false
            btnCancel.setTitle("\(textBtnCancel)", for: UIControl.State.normal)
        }
    }
}
