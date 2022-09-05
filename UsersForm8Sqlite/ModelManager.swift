//
//  ModelManager.swift
//  UsersForm8Sqlite
//
//  Created by Dane on 30/8/22.
//

import Foundation
import UIKit

var shareInstance = ModelManager()

class ModelManager {
    
    var database: FMDatabase? = nil
    
    static func getInstance() -> ModelManager {
        if shareInstance.database == nil {
            shareInstance.database = FMDatabase(path: Util.shared.getPath(dbName: Util.shared.databaseName))
        }
        return shareInstance
    }
    
    func saveUserData(user: UserModel) -> Bool {
//        shareInstance.database?.open()
    
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO user(username, userrole, userdob) VALUES (?,?,?)", withArgumentsIn: [user.username, user.userrole, user.userdob])
    
//        shareInstance.database?.close()
        return isSave!
    }
    
    func getAllUserData() -> [UserModel] {
        shareInstance.database?.open()
        var users = [UserModel]()
        do {
            let resultSet : FMResultSet? = try shareInstance.database?.executeQuery("SELECT id, username, userrole, userdob, createat FROM user", values: nil)
            
            if resultSet != nil {
                while (resultSet!.next()) {
                    let user = UserModel(id: (resultSet!.string(forColumn: "id")!), username: (resultSet!.string(forColumn: "username")!), userrole: (resultSet!.string(forColumn: "userrole")!), userdob: (resultSet?.string(forColumn: "userdob")!)!, usercreateat: (resultSet!.string(forColumn: "createat")) ?? "Cannot Updated Date")
                    users.append(user)
                }
            }
        }
        catch let err {
            print(err.localizedDescription)
        }
//        shareInstance.database?.close()
        return users
    }
    
    func updateUser(user: UserModel) -> Bool {
//        shareInstance.database?.open()
        
        let isUpdated = shareInstance.database?.executeUpdate("UPDATE user SET username = ?, userrole = ?, userdob = ?, createat = ? WHERE id = ?", withArgumentsIn: [user.username, user.userrole, user.userdob, user.usercreateat ?? Date().description, user.id])
        
//        shareInstance.database?.close()
//        print(shareInstance.database?.lastError().localizedDescription)
        return isUpdated!
    }
    
    func deleteUser(user: UserModel) -> Bool {
//        shareInstance.database?.open()
        
        let isDeleted = shareInstance.database?.executeUpdate("DELETE FROM user WHERE username = ?", withArgumentsIn: [user.username])
        
//        shareInstance.database?.close()
        
        return isDeleted!
    }
    
    

}















////Creating global instance
//var shareInstance = ModelManager()
//
//class ModelManager {
//
//    var database: FMDatabase? = nil
//
//    static func getInstance() -> ModelManager {
//        if shareInstance.database == nil {
//            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "Sqlite.db"))
//        }
//        return shareInstance
//    }
//
//    func getPath(dbName: String) -> String {
//        let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let fileUrl = fileDirectory.appendingPathComponent("/\(dbName)")
//        print(fileUrl.path)
//        return fileUrl.path
//    }
//
//
//    //MARK: Saving user data
//    func saveUserData(user: UserModel) -> Bool {
//        shareInstance.database?.open()
//
//        let isSave = shareInstance.database?.executeUpdate("INSERT INTO user (username, userrole) VALUES (?,?)", withArgumentsIn: [user.username, user.userrole])
//
//        shareInstance.database?.close()
//        return isSave!
//    }
//}
