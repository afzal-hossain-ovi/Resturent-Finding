//
//  MapVC.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/26/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var cityModel: CityModel!
    var transmittedLatitude = 0.0
    var transmittedLongitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let coordinate = CLLocationCoordinate2D(latitude: transmittedLatitude, longitude: transmittedLongitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = cityModel.resName
        annotation.subtitle = cityModel.resAddress
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
    }


}
