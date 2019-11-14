//
//  IqroPresenter.swift
//  iQroku
//
//  Created by NDS on 04/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol IqroViewPresenter: class {
    init(view: IqroView)
    func getIqroCount() -> Int
    func getListIqroPage()
    func loadPage()
    func getIqroPageItem() -> [IqroPage]
}

protocol IqroView: class {
    // TODO: Declare view methods
}

class IqroPresenter: IqroViewPresenter {
    
    static func config(withIqroViewController viewController: IqroViewController) {
        let presenter = IqroPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: IqroView
    let iqroCount: Int = 6
    var listIqroPage = [IqroPage]()
    
    required init(view: IqroView) {
        self.view = view
    }
    
    func getIqroCount() -> Int {
        return iqroCount
    }
    
    func getListIqroPage() {
        listIqroPage = IqrokuDB.instance.getIqroPage()
    }
    
    func loadPage() {
        getListIqroPage()
    }
    
    func getIqroPageItem() -> [IqroPage] {
        return listIqroPage
    }
}
