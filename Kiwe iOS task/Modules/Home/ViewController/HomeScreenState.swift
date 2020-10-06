//
//  HomeScreenState.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation

enum HomeScreenState{
    case Success(places:[Venue])
    case Failure
    case Loading
    
    static func toState(response:PlacesResponse)->HomeScreenState{
        if response.meta.code == 200 {
            return .Success(places: response.response.venues)
        }else{
            return .Failure
        }
    }
}
