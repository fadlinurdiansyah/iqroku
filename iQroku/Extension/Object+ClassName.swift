//
//  Object+ClassName.swift
//  iQroku
//
//  Created by NDS on 05/10/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
