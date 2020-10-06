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
    
    private let provider = MoyaProvider<PlacesApis>(plugins:[VerbosePlugin(verbose: true)])
    
    func getPlaces(latitude:String, longitude: String) -> Single<PlacesResponse> {
        return provider.rx.request(.getPlaces(latitude: latitude, longitude: longitude)).map({
            try JSONDecoder().decode(PlacesResponse.self, from: $0.data)
        })
        
    }
}

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str))")
        }
        #endif
        return request
    }
}
