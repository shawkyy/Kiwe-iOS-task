//
//  ViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import SideMenu
import GoogleMaps
import RxSwift
import PKHUD
import Kingfisher

private enum ScreenSelection{
    case Places
    case Map
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var mapParentView: UIView!
    @IBOutlet weak var placesSeparator: UIView!
    @IBOutlet weak var mapSeparator: UIView!
    
    private let locationManager = CLLocationManager()
    private var latitude : Double?
    private  var longitude : Double?
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var places = [Venue]()
    var userName:String?
    private var screenSelection: ScreenSelection = .Places {
        didSet {
            handleScreenSelection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubscribers()
        locationManager.requestWhenInUseAuthorization()
        configureTableView()
        handleScreenSelection()
        viewModel.getPlaces()
    }
    
    private func setSubscribers(){
        viewModel.homeStateBehaviorSubject.subscribe(onNext: { screenState in
            self.handleScreenState(screenState)
        }).disposed(by: disposeBag)
    }
    
    private func handleScreenState(_ screenState: HomeScreenState){
        switch screenState {
        case .Failure:
            //handle failure
            HUD.show(.progress)
        case.Loading:
            HUD.show(.progress)
        case.Success(places: let places):
            self.places = places
            self.placesTableView.reloadData()
            configureMapView()
            HUD.hide()
        }
    }
    
    private func configureMapView(){
        GMSServices.provideAPIKey("AIzaSyAlfYIoxo6mzDTh2eY7UbLE58GjgGiyENo")
        let lng = places[0].location.lng
        let lat = places[0].location.lat
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.mapParentView.addSubview(mapView)
        
        for place in places{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.location.lat, longitude: place.location.lng)
            marker.appearAnimation = .pop
            marker.title = place.name
            if !place.categories.isEmpty{
                marker.snippet = place.categories[0].name
            }
            marker.map = mapView
        }
    }
    
    private func configureTableView(){
        placesTableView.dataSource = self
        placesTableView.register(UINib(nibName: PlaceTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }
    
    private func handleScreenSelection(){
        switch screenSelection{
        case .Map:
            mapParentView.isHidden = false
            mapSeparator.backgroundColor = .darkGray
            placesSeparator.backgroundColor = .clear
        case.Places:
            mapParentView.isHidden = true
            mapSeparator.backgroundColor = .clear
            placesSeparator.backgroundColor = .darkGray
        }
    }
    
    @IBAction func placesButtonDidTap(_ sender: Any) {
        screenSelection = .Places
    }
    
    @IBAction func mapButtonDidTap(_ sender: Any) {
        screenSelection = .Map
    }
    
    @IBAction func sideMenuButtonDidTap(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = SideMenuNavigationController(rootViewController: viewController)
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        menu.navigationBar.isHidden = true
        menu.dismissOnPresent = true
        menu.dismissOnPush = true
        present(menu, animated: true, completion: nil)
    }
}

extension HomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else{return UITableViewCell()}
        let place = places[indexPath.row]
        cell.placeName.text = place.name
        if !place.categories.isEmpty{
            cell.categoryName.text = place.categories[0].name
            //
            cell.categoryImage.kf.setImage(with: URL(string: "\(place.categories[0].icon.iconPrefix)64.png"))
        }
        
        return cell
    }
    
}

extension HomeViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print(marker.title)
    }
}
