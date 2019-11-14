//
//  MainPresenter.swift
//  iQroku
//
//  Created by NDS on 02/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol MainViewPresenter: class {
    init(view: MainView)
    
    func getCountMainMenu() -> Int
}

protocol MainView: class {
    // TODO: Declare view methods
}

class MainPresenter: MainViewPresenter {
    
    static func config(withMainViewController viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: MainView
    let menuCount: Int = 5
//    let listColourMenu: [] = [ColourConstant.]
    
    required init(view: MainView) {
        self.view = view
    }
    
    func getCountMainMenu() -> Int {
        return menuCount
    }
    
}
