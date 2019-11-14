//
//  UIView+Nib.swift
//  iQroku
//
//  Created by NDS on 05/10/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(type(of: self).className, owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }
}
