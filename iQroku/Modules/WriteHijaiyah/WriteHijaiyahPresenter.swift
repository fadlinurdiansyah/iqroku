//
//  WriteHijaiyahPresenter.swift
//  iQroku
//
//  Created by NDS on 13/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol WriteHijaiyahViewPresenter: class {
    init(view: WriteHijaiyahView)
    func getCountHijaiyah() -> Int
}

protocol WriteHijaiyahView: class {
    // TODO: Declare view methods
}

class WriteHijaiyahPresenter: WriteHijaiyahViewPresenter {
   
    static func config(withWriteHijaiyahViewController viewController: WriteHijaiyahViewController) {
        let presenter = WriteHijaiyahPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: WriteHijaiyahView
    let countHijaiyah: Int = 30
    
    required init(view: WriteHijaiyahView) {
        self.view = view
    }
    
    func getCountHijaiyah() -> Int {
        return countHijaiyah
    }
}
