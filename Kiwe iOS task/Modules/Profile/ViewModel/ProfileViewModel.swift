//
//  ProfileViewModel.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

class ProfileViewModel{
    
    private let useCases = ProfileUseCases()
    var name:String?
    var age:String?
    var email:String?
    
    init() {
        getUserData()
    }
    
    func getUserData(){
        let data = useCases.getUserData()
        self.name  = data?.name
        self.age = data?.age
        self.email = data?.email
    }
}

