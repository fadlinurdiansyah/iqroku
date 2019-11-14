//
//  config.swift
//  iQroku
//
//  Created by NDS on 09/10/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation

class Config {
    let keyConfig: String?
    let value: Int64?
    
    init(keyConfig: String, value: Int64) {
        self.keyConfig = keyConfig
        self.value = value
    }
}
