//
//  DetailsVC.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/23/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

class DetailsVC: UIViewController,MKMapViewDelegate {
    
    var cityModel: CityModel!

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var webSiteLbl: UILabel!
    @IBOutlet weak var ratingImgView: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
   
    
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude = 0.0
    var longitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: cityModel.resPlaceId) { (photo, error) in
            if error != nil {
                print("error: \(error?.localizedDescription)")
            }else {
                if let firstPhoto = photo?.results.first {
                    GMSPlacesClient.shared().loadPlacePhoto(firstPhoto, callback: { (image, error) in
                        if error != nil {
                            print("error: \(error?.localizedDescription)")
                        }else {
                            self.imgView.image = image
                            
                        }
                    })
                }
            }
        }
        
        GMSPlacesClient().lookUpPlaceID(cityModel.resPlaceId) { (place, error) in
            if error != nil {
                print("error: \(error?.localizedDescription)")
            }else {
                self.addressLbl.text = "Address: \((place?.formattedAddress)!)."
                if place?.website != nil {
                    self.phoneLbl.text = place?.phoneNumber
                }else {
                    self.webSiteLbl.text = "none"
                }
                if place?.website != nil {
                    self.webSiteLbl.text = "\((place?.website)!)"
                }else {
                    self.webSiteLbl.text = "none"
                }
                
                if self.cityModel.resOpenInfo == "true" {
                    self.openLbl.text = "Open"
                }else if self.cityModel.resOpenInfo == "false" {
                    self.openLbl.text = "Closed"
                }else {
                    self.openLbl.text = ""
                }
                
                self.latitude = (place?.coordinate.latitude)!
                self.longitude = (place?.coordinate.longitude)!
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
//                let annotation = MKPointAnnotation()
//                annotation.title = self.cityModel.resName
//                annotation.coordinate = coordinate
//                self.mapView.addAnnotation(annotation)
                
            }
        }
        ratingLbl.text = "(\(cityModel.resRating))"
        ratingImgView.image = getRatingStarImgFor(cityModel.resRating)
        
        mapView.isUserInteractionEnabled = true
        let mapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailsVC.mapTapped))
        mapView.addGestureRecognizer(mapGesture)
    }
    
    func mapTapped() {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    
    func getRatingStarImgFor(_ rating: Double) -> UIImage? {
        let roundedRating = Double(Int(rating * 2 + 0.5))/2.0
        return UIImage(named: "staar\(roundedRating).png")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVC = segue.destination as? MapVC {
            mapVC.transmittedLatitude = self.latitude
            mapVC.transmittedLongitude = self.longitude
            mapVC.cityModel = cityModel
            
        }
    }


}
