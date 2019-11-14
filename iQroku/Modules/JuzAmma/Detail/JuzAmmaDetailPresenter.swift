//
//  JuzAmmaDetailPresenter.swift
//  iQroku
//
//  Created by NDS on 11/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol JuzAmmaDetailViewPresenter: class {
    init(view: JuzAmmaDetailView)
    func getTotalPages() -> Int
    func getNavTitle() -> String
    func getCurrentPage() -> Int
}

protocol JuzAmmaDetailView: class {
    // TODO: Declare view methods
}

class JuzAmmaDetailPresenter: JuzAmmaDetailViewPresenter {
    
    static func config(withJuzAmmaDetailViewController viewController: JuzAmmaDetailViewController) {
        let presenter = JuzAmmaDetailPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: JuzAmmaDetailView
    let totalPages: Int = 20
    let navTitle: String = "AL - FATIHAH"
    var currentPage: Int = 0
    
    required init(view: JuzAmmaDetailView) {
        self.view = view
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
    func getNavTitle() -> String {
        return navTitle
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
}
