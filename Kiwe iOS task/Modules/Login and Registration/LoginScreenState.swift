//
//  LoginScreenState.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

enum LoginScreenState {
    case Success(email:String)
    case Failure
    case Loading
}
