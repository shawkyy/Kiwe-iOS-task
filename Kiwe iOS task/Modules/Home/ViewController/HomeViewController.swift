//
//  ViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import SideMenu
import CoreLocation
import GoogleMaps

enum HomeScreenSelection{
    case Places
    case Map
}

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var mapParentView: UIView!
    @IBOutlet weak var placesSeparator: UIView!
    @IBOutlet weak var mapSeparator: UIView!
    
    private let locationManager = CLLocationManager()
    private var latitude : Double?
    private  var longitude : Double?
    private let viewModel = HomeViewModel()
    private var homeScreenSelection: HomeScreenSelection = .Places {
        didSet {
            handleScreenSelection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        configureTableView()
        configureMapView()
        locationManager.delegate = self
        handleScreenSelection()
        getUserLocation()
        guard let latitude = latitude, let longitude = longitude else {return}
                viewModel.getPlaces(latitude: "\(latitude)", longitude: "\(longitude)")
    }
    
    private func configureMapView(){
        GMSServices.provideAPIKey("AIzaSyAlfYIoxo6mzDTh2eY7UbLE58GjgGiyENo")

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.mapParentView.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.appearAnimation = .pop
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    private func configureTableView(){
        placesTableView.dataSource = self
        placesTableView.register(UINib(nibName: PlaceTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PlaceTableViewCell.identifier)
    }
    
    private func handleScreenSelection(){
        switch homeScreenSelection{
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
    
    func getUserLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // set the value of lat and long
        latitude = location.latitude
        longitude = location.longitude

        
    }
    
    
    @IBAction func placesButtonDidTap(_ sender: Any) {
        homeScreenSelection = .Places
    }
    
    @IBAction func mapButtonDidTap(_ sender: Any) {
        homeScreenSelection = .Map
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
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else{return UITableViewCell()}
        cell.categoryName.text = "shawky"
        return cell
    }
    
    
}

extension HomeViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print(marker.title)
    }
}
