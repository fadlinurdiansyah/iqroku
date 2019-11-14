//
//  IqrokuDB.swift
//  iQroku
//
//  Created by NDS on 28/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import SQLite

class IqrokuDB {
    static let instance = IqrokuDB()
    private var database: Connection?
    
    private init() {
        
        let documentDirectory = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        let dbPath = documentDirectory?.appendingPathComponent("DB")
        let pathDestination = dbPath?.appendingPathComponent("iqrokuDB.sqlite3").path
        
        do {
            database = try Connection(pathDestination!)
            print(pathDestination)
        } catch {
            database = nil
            print("Cannot to open database with error\(error)")
        }
    }
    
    func createSQLite() {
        do {
            let documentDirectory = try FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("iqrokuDB").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
            print(documentDirectory)
        } catch {
            print(error)
        }
    }
    
    func createTableIqro() {
        let tableIqro = Table("iqro")
        let number = Expression<Int64>("number")
        let page = Expression<Int64?>("page")
        let done = Expression<String?>("done")
        do {
            try database?.run(tableIqro.create { data in
                data.column(number)
                data.column(page)
                data.column(done, defaultValue: "N")
            })
        } catch {
            print("Error Create Table Iqro \(error)")
        }
        
    }
    
    func createTableJuzAmmaHeader() {
        let tableJuzAmmaHeader = Table("juzamma_hd")
        let surahId = Expression<Int64>("surah_id")
        let surahName = Expression<String?>("surah_name")
        
        do {
            try database?.run(tableJuzAmmaHeader.create { data in
                data.column(surahId)
                data.column(surahName)
            })
        } catch {
            print("Error Create Table JuzAmma Header \(error)")
        }
        
    }
    
    func createTableJuzAmmaDetail() {
        let tableJuzAmmaDetail = Table("juzamma_dt")
        let surahId = Expression<String?>("surah_id")
        let page = Expression<Int64>("page")
        
        do {
            try database?.run(tableJuzAmmaDetail.create { data in
                data.column(surahId)
                data.column(page)
            })
        } catch {
            print("Error Create Table JuzAmma Detail \(error)")
        }
        
    }
    
    func createTableConfig() {
        let tableConfig = Table("config")
        let keyConfig = Expression<String>("key")
        let value = Expression<Int64>("value")
        
        do {
            try database?.run(tableConfig.create { data in
                data.column(keyConfig, primaryKey: true)
                data.column(value)
            })
        } catch {
            print("Error create table config \(error)")
        }
    }
    
    func insertIqroData() {
        let numIqro: [Int] = [1, 2, 3, 4, 5, 6]
        let pageIqro: [Int] = [31, 52, 66, 86, 105, 125]
        
        for number in numIqro {
            let index1 = number - 1 // 0, 1, 2, 3, 4, 5
            let index2 = number // 1, 2, 3, 4, 5, 6
            var sqlInsert: String = ""
            
            print("\(index1) - \(index2)")
            if index1 == 0 {
                for page in 1...pageIqro[index1] {
                    sqlInsert = "INSERT INTO iqro(number,page) values (1,\(page))"
                    do {
                        try database?.run(sqlInsert)
                    } catch {
                        print("Error Insert Data Iqro \(error)")
                    }
                    print(sqlInsert)
                }
            } else if index1 != 0 {
                for page in pageIqro[index1 - 1] + 1...pageIqro[index2 - 1] {
                    sqlInsert = "INSERT INTO iqro(number,page) values (\(index2),\(page))"
                    do {
                        try database?.run(sqlInsert)
                    } catch {
                        print("Error Insert Data Iqro \(error)")
                    }
                    print(sqlInsert)
                }
            }
            
        }
    }
    
    func copyDB() {
        let documentDirectory = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        let dbPath = documentDirectory?.appendingPathComponent("DB")
        let bundlePath = Bundle.main.path(forResource: "iqrokuDB", ofType: "sqlite3")
        let pathDestination = dbPath?.appendingPathComponent("iqrokuDB.sqlite3").path
        
        if !FileManager.default.fileExists(atPath: (dbPath?.path)!) {
            
            // Create DB Directory
            do {
                try FileManager.default.createDirectory(atPath: ((dbPath?.path)!), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Cannot create folder DB \(error)")
            }
            
            // Copy File SQLite
            do {
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: pathDestination!)
            } catch {
                print("Cannot copy master database \(error)")
            }
        }
        print("\(dbPath)")
    }
    
    func getIqro(withId id: Int) -> [Iqro] {
        var iqro = [Iqro]()
        
        do {
            for data in try (database?.prepare("SELECT ROWID, * FROM iqro WHERE number = \(id)"))! {
                iqro.append(Iqro(rowid: data[0] as! Int64,
                                 number: data[1] as! Int64,
                                 page: data[2] as! Int64,
                                 done: data[3] as! String))
            }
        } catch {
            print("Error select iqro \(error)")
        }
        
        return iqro
    }
    
    func getIqroPage() -> [IqroPage] {
        var iqroPage = [IqroPage]()
        
        do {
            for data in try (database?.prepare("SELECT number, COUNT(number) FROM iqro GROUP BY number"))! {
                iqroPage.append(IqroPage(number: data[0] as! Int64,
                                         page: data[1] as! Int64))
            }
        } catch {
            print("Error get iqro page \(error)")
        }
        
        return iqroPage
    }
    
    func update(withQuery query: String) -> Bool {
        do {
            try database?.run(query)
        } catch {
            print("Cannot update data \(error)")
        }
        return true
    }
    
    func insert(withQuery query: String) -> Bool {
        do {
            try database?.run(query)
        } catch {
            print("Cannot insert data \(error)")
        }
        
        return true
    }
    
    func dropTable(withTable table: String) -> Bool {
        do {
            try database?.run("DROP TABLE \(table)")
        } catch {
            print("Cannot drop table \(error)")
        }
        
        return true
    }
    
    func scalar(withQuery query: String) -> AnyObject {
        var data: AnyObject?
        
        do {
            data = try database?.scalar(query) as AnyObject
            
        } catch {
            print("Cannot get data scalar \(error)")
        }
        
        return data as AnyObject
    }
}
