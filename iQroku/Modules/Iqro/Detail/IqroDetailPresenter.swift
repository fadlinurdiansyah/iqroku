//
//  IqroDetailPresenter.swift
//  iQroku
//
//  Created by NDS on 05/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON

protocol IqroDetailViewPresenter: class {
    init(view: IqroDetailView)
//    func getTotalPages() -> Int
    func getNavTitle() -> String
    func getCurrentPage() -> Int
    func getIqroNumber() -> Int
    func getListIqro()
    func loadPage()
    func updatePage()
    func getIqroItem() -> [Iqro]
    func getCompletePage() -> Int
    func checkCompletePage()
}

protocol IqroDetailView: class {
    func updateRightBarButton()
    func showNotifCompletePage()
    func showCompletePagePopup()
}

class IqroDetailPresenter: IqroDetailViewPresenter {
    
    static func config(withIqroDetailViewController viewController: IqroDetailViewController) {
        let presenter = IqroDetailPresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: IqroDetailView
    var navTitle: String = ""
    var currentPage: Int = 0
    var iqroNumber: Int = 0
    var listIqro = [Iqro]()
    var isDone: Bool = false
    var completePage = 0
    var rowId: Int64 = 0
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    required init(view: IqroDetailView) {
        self.view = view
    }
    
//    func getTotalPages() -> Int {
//        return totalPages
//    }
    
    func getNavTitle() -> String {
        navTitle = "IQRO \(iqroNumber)"
        return navTitle
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
    
    func getIqroNumber() -> Int {
        return iqroNumber
    }
    
    func getListIqro() {
        listIqro = IqrokuDB.instance.getIqro(withId: iqroNumber)
    }
    
    func getIqroItem() -> [Iqro] {
        return listIqro
    }
    
    func getCountIqro() -> Int {
        return listIqro.count
    }
    
    func loadPage() {
        getListIqro()
    }
    
    func getCompletePage() -> Int {
        
        completePage = IqrokuDB.instance.scalar(withQuery: "SELECT value FROM config WHERE key = 'iq\(iqroNumber)'") as! Int
        return completePage
    }
    
    func updatePage() {
        
        if isDone {
            print("UnComplete")
            isDone = false
            
            if IqrokuDB.instance.update(withQuery: "UPDATE iqro SET done = 'N' where ROWID = \(rowId) ") {
                loadPage()
                self.view.updateRightBarButton()
            }
        } else {
            print("Complete")
            isDone = true
            if IqrokuDB.instance.update(withQuery: "UPDATE iqro SET done = 'Y' where ROWID = \(rowId) ") {
                if IqrokuDB.instance.update(withQuery: "UPDATE config SET `value` = '\(currentPage + 1)' WHERE key = 'iq\(iqroNumber)'") {
                    loadPage()
                    self.view.updateRightBarButton()
                    self.view.showNotifCompletePage()
                }
            }
        }
    }
    
    func checkCompletePage() {
        if completePage != 0 {
            self.view.showCompletePagePopup()
        }
    }
    
}
