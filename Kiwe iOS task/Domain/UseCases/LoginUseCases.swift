//
//  LoginUseCases.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import RxSwift

class LoginUseCases {
    
    func saveUserAccount(userName:String, password:String, age:String, email:String){
        LocalData.saveUserAccount(userName: userName, password: password, age: age, email: email)
    }
    
    func saveUserEmail(email:String){
        LocalData.saveEmail(with: email)
    }
    
    func retrieveUserAccount(email:String)->(name:String, password:String, email:String, age:String)?{
        
        let dataDictionary =  LocalData.retrieveUserAccount(email: email)
        return (name: "\(dataDictionary?["name"] ?? "")",
            password: "\(dataDictionary?["password"] ?? "")"
            , email: "\(dataDictionary?["email"] ?? "")",
            age: "\(dataDictionary?["age"] ?? "")")
    }
    
    func retrieveUserPassword(email:String)->String?{
        let dataDictionary =  LocalData.retrieveUserAccount(email: email)
        return "\(dataDictionary?["password"] ?? "")"
    }
    
}
