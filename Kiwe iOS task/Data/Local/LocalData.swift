//
//  LocalData.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import Locksmith

struct LocalData  {
   
    static func saveUserAccount(userName:String, password:String, age:String, email:String) {
        try? Locksmith.saveData(data: [
            "password": "\(password)",
            "age":"\(age)",
            "name":"\(userName)"]
            , forUserAccount: "\(email)")
    }
    
    static func retrieveUserAccount(email:String)->[String:Any]?{
        Locksmith.loadDataForUserAccount(userAccount: "\(email)")
    }
    
    static func saveEmail(with token:String){
        UserDefaults.standard.set(token, forKey: "email")
    }
    
    static func retrieveUserEmail()->String{
        UserDefaults.standard.string(forKey: "email") ?? ""
    }
    
    static func saveLocation(location:String){
        UserDefaults.standard.set(location, forKey: "location")
    }
    
    static func retrieveLocation()->String{
        UserDefaults.standard.string(forKey: "location") ?? ""
    }
    
    
}
