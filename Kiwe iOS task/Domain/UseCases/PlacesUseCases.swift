//
//  PlacesUseCases.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import RxSwift

class PlacesUseCases {
    
    let dataSource: PlacesDataSource
    
    init() {
        self.dataSource = MoyaPlacesDataSource()
    }
    
    func getPlaces(latitude:String, longitude:String)->Single<HomeScreenState>{
        dataSource.getPlaces(latitude: latitude, longitude: longitude).map({HomeScreenState.toState(response: $0)})
    }
}
