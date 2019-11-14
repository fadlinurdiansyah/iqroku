//
//  ListIqro.swift
//  iQroku
//
//  Created by NDS on 29/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation

class Iqro {
    
    let rowid: Int64?
    let number: Int64?
    let page: Int64?
    let done: String?
    
    init(rowid: Int64, number: Int64, page: Int64, done: String) {
        self.rowid = rowid
        self.number = number
        self.page = page
        self.done = done
    }
    
}
