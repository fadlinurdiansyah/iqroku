
//
//  BaseDAO.swift
//  iQroku
//
//  Created by NDS on 11/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

//import Foundation
//import SwiftyJSON
//
//class BaseDAO {
//
//    static private let kSuccessKey = "success"
//    static private let kMessageKey = "message"
//    static private let kErrorKey = "ERROR_RESPONSE"
//
//    var success: Bool = false
//    var message: String?
//    var error: ErrorExceptionAPI?
//
//    init(json: JSON? = nil) {
//        if let json = json {
//            success = json[BaseDAO.kSuccessKey].boolValue
//            message = json[BaseDAO.kMessageKey].string
//            if json[BaseDAO.kErrorKey].exists() {
//                error = ErrorExceptionAPI(json: json[BaseDAO.kErrorKey])
//            }
//        }
//    }
//
//    func isError() -> Bool {
//        return error != nil
//    }
//}
