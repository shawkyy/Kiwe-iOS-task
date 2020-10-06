//
//  LoginViewModel.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    let loginBehaviorSubject =  BehaviorSubject<LoginScreenState>(value: .Loading)
    
    private let useCases = LoginUseCases()
    
    func registerUser(userName:String, password:String, age:String, email:String){
        useCases.saveUserAccount(userName: userName, password: password, age: age, email: email)
    }
    
    func login(email:String, password:String) {
        loginBehaviorSubject.onNext(.Loading)
        guard let savedPassword = useCases.retrieveUserPassword(email: email) else {return}
        if password == savedPassword{
            loginBehaviorSubject.onNext(.Success(email: email))
        }else{
            loginBehaviorSubject.onNext(.Failure)
        }
    }
    
    func saveUserEmail(email:String){
        useCases.saveUserEmail(email: email)
    }
}

