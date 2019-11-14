//
//  BasePagination.swift
//  iQroku
//
//  Created by NDS on 11/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
//import SwiftyJSON
//
//class BasePagination {
//
//    static private let kInitialPage: Int = 1
//    static private let kCurrentPageKey = "currentPage"
//    static private let kSortStr = "sortStr"
//    static private let kTotalPages = "totalPages"
//    static private let kFirstPage = "firstPage"
//    static private let kLastPage = "lastPage"
//    static private let kCount = "count"
//    static private let kStart = "start"
//    static private let kSize = "size"
//
//    var currentPage: Int = kInitialPage
//    var sortStr: String?
//    var totalPages: Int = 1
//    var firstPage: Bool = true
//    var lastPage: Bool = true
//    var count: Int = 0
//    var start: Int = 0
//    var size: Int = 0
//
//    init(json: JSON? = nil) {
//        if let json = json {
//            currentPage = json[BasePagination.kCurrentPageKey].intValue
//            sortStr = json[BasePagination.kSortStr].string
//            totalPages = json[BasePagination.kTotalPages].intValue
//            firstPage = json[BasePagination.kFirstPage].boolValue
//            lastPage = json[BasePagination.kLastPage].boolValue
//            count = json[BasePagination.kCount].intValue
//            start = json[BasePagination.kStart].intValue
//            size = json[BasePagination.kSize].intValue
//        }
//    }
//
//    func isFirstPage() -> Bool {
//        return currentPage == BasePagination.kInitialPage
//    }
//
//    func isEndPage() -> Bool {
//        return currentPage >= totalPages
//    }
//
//    func getNextCurrentPage() -> Int {
//        return currentPage + BasePagination.kInitialPage
//    }
//
//    func isItemEmpty() -> Bool {
//        let countItem = count
//        return countItem == 0
//    }
//
//    func isLastPage() -> Bool {
//        return lastPage
//    }
//}
