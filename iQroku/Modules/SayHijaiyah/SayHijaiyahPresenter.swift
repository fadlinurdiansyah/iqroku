//
//  SayHijaiyahPresenter.swift
//  iQroku
//
//  Created by NDS on 21/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol SayHijaiyahViewPresenter: class {
    init(view: SayHijaiyahView)
    func getCountHijaiyah() -> Int
    func getCurrentHijaiyah() -> Int
}

protocol SayHijaiyahView: class {
    // TODO: Declare view methods
}

class SayHijaiyahPresenter: SayHijaiyahViewPresenter {
    
    static func config(withSayHijaiyahViewController viewController: SayHijaiyahViewController) {
        let presenter = SayHijaiyahPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: SayHijaiyahView
    let countHijaiyah: Int = 30
    var currentHijaiyah: Int = 1
    
    required init(view: SayHijaiyahView) {
        self.view = view
    }
    
    func getCountHijaiyah() -> Int {
        return countHijaiyah
    }
    
    func getCurrentHijaiyah() -> Int {
        return currentHijaiyah
    }
}
