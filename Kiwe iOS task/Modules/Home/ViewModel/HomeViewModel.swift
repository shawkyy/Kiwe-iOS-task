//
//  HomeViewModel.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private let useCases = PlacesUseCases()

    private let disposeBag = DisposeBag()
    let homeStateBehaviorSubject = BehaviorSubject<HomeScreenState>(value: .Loading)
    
    func getPlaces(latitude:String,longitude:String){
        useCases.getPlaces(latitude: "\(latitude)", longitude: "\(longitude)").subscribe(onSuccess: { (screenState) in
            self.homeStateBehaviorSubject.onNext(screenState)
        }) { [weak self](error) in
            self?.homeStateBehaviorSubject.onNext(.Failure)
        }.disposed(by: disposeBag)
    }
}
