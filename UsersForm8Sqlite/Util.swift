//
//  Util.swift
//  UsersForm8Sqlite
//
//  Created by Dane on 30/8/22.
//

import UIKit

class Util: NSObject{
    
    let fUserID = " "
    let fUserName = " "
    let fUserRole = " "
    let fUserDOB = " "
    
    static let shared: Util = Util()
    let databaseName = "Sqlite.db"
    var dbPath: String!
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        dbPath = documentsDirectory.appending("/\(databaseName)")
    }
    
    func getPath(dbName: String) -> String {
        let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = fileDirectory.appendingPathComponent(dbName)
        print(fileUrl.path)
        return fileUrl.path
    }
    
    func createDatabase() -> Bool {
        var created = false
        
//        if FileManager.default.fileExists(atPath: dbPath) {
            database = FMDatabase(path: dbPath)
            
            if database != nil {
                //Open database.
                if database.open() {
                    let createUserTableQuery = "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, username TEXT NOT NULL, userrole TEXT NOT NULL, userdob TEXT NOT NULL, createat TEXT DEFAULT CURRENT_TIMESTAMP)"
                    
                    do {
                        try database.executeUpdate(createUserTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
//                    database.close()
                }
//                else {
//                    print("Could not open the database.")
//                }
            }
  //      }
        
        return created
    }
    
    func openDatabase() -> Bool {
        
        if database == nil {
            if FileManager.default.fileExists(atPath: dbPath) {
                database = FMDatabase(path: dbPath)
            }
        }
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
        
    func insertUserData() {
        if openDatabase() {
            
        }
    }
}












////MARK: Getting database path
//
//func getPath(dbName: String) -> String {
//    let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let fileUrl = fileDirectory.appendingPathComponent(dbName)
//    print(fileUrl.path)
//    return fileUrl.path
//}
//
////MARK: If database path is not exists the creating database path
//func copyDatabase(dbName: String) {
//    let dbPath = getPath(dbName: "Sqlite.db")
//    let fileManager = FileManager.default
//
//    if !fileManager.fileExists(atPath: dbPath){
//        let bundle = Bundle.main.resourceURL
//        let file = bundle?.appendingPathComponent(dbName)
//        do {
//            try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
//        }
//        catch let err{
//            print(err.localizedDescription)
//        }
//    }
//}
