//
//  MoyaPlacesDataSource.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MoyaPlacesDataSource: PlacesDataSource {
    
    private let provider = MoyaProvider<PlacesApis>(plugins:[NetworkLoggerPlugin()])
    
    func getPlaces(location:String) -> Single<PlacesResponse> {
        return provider.rx.request(.getPlaces(location: location)).map({
            try JSONDecoder().decode(PlacesResponse.self, from: $0.data)
        })
        
    }
}

