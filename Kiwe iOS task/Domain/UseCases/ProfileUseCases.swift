//
//  ProfileUseCases.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

class ProfileUseCases {
    
    func getUserData()->(name:String,age:String,email:String)?{
        let userEmail = LocalData.retrieveUserEmail()
        let userAccount = LocalData.retrieveUserAccount(email: userEmail)
      
        return ("\(userAccount?["name"] ?? "")","\(userAccount?["age"] ?? "")",userEmail)
    }
    
}
