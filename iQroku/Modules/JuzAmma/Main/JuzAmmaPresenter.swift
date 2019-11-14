//
//  JuzAmmaPresenter.swift
//  iQroku
//
//  Created by NDS on 09/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol JuzAmmaViewPresenter: class {
    init(view: JuzAmmaView)
    func getTotalJuzAmma() -> Int
}

protocol JuzAmmaView: class {
    // TODO: Declare view methods
}

class JuzAmmaPresenter: JuzAmmaViewPresenter {
    
    static func config(withJuzAmmaViewController viewController: JuzAmmaViewController) {
        let presenter = JuzAmmaPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: JuzAmmaView
    let totalJuzAmma: Int = 10
    
    required init(view: JuzAmmaView) {
        self.view = view
    }
    
    func getTotalJuzAmma() -> Int {
        return totalJuzAmma
    }
    
 
}
