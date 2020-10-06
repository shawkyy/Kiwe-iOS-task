//
//  PlacesApis.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import Moya

enum PlacesApis{
    case getPlaces(location:String)
}

extension PlacesApis: TargetType{
    
    var baseURL: URL {
        URL(string: "\(Constants.Urls.baseUrl)")!
    }
    
    var path: String {
        switch self {
        case .getPlaces:
            return Constants.Urls.searchPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPlaces:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPlaces(location: let location):
            return .requestParameters(parameters: [
                "ll":"\(location)",
                "client_id":"4EQRZPSGKBZGFSERGJY055FRW2OSPJRZYR4C3J0JN2CQQFIV",
                "client_secret":"AJR4B5LLRONWAJWJJOACHAFLCWS2YJAZMGQNFFZQP0IB3THR",
                "v":"20180910"
                ]
                ,encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
