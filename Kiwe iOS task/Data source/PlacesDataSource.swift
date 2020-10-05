//
//  PlacesDataSource.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import RxSwift

protocol PlacesDataSource {
    func getPlaces(with location:String)->Single<PlacesResponse>
}
