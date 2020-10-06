//
//  MapViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAlfYIoxo6mzDTh2eY7UbLE58GjgGiyENo")
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 2.0)
        
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.appearAnimation = .pop
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: -32.86, longitude: 154.20)
        marker2.appearAnimation = .pop
        marker2.title = "aboelsho2"
        let view = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .blue
        marker2.iconView = view
        
        marker2.snippet = "ssajjsasjas: jsajd, jaskdas ,"
        marker2.map = mapView
        
  
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print(marker.title)
    }
    
    
}
