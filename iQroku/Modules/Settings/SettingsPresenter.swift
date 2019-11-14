//
//  SettingsPresenter.swift
//  iQroku
//
//  Created by NDS on 23/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol SettingsViewPresenter: class {
    init(view: SettingsView)
    func getListLanguage() -> [String]
}

protocol SettingsView: class {
    // TODO: Declare view methods
}

class SettingsPresenter: SettingsViewPresenter {
    
    static func config(withSettingsViewController viewController: SettingsViewController) {
        let presenter = SettingsPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: SettingsView
    let listLanguage: [String] = ["Indonesia", "English"]
    
    required init(view: SettingsView) {
        self.view = view
    }
    
    func getListLanguage() -> [String] {
        return listLanguage
    }
}
