//
//  CityTableCell.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/21/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import GooglePlaces


class CityTableCell: UITableViewCell {

    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var openNowLbl: UILabel!
    @IBOutlet weak var ratingImgView: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    
    func configureCell(cityModel: CityModel) {
        placeNameLbl.text = cityModel.resName
        addressLbl.text = "Address:"+cityModel.resAddress
        if cityModel.resOpenInfo == "true" {
            openNowLbl.text = "Open"
        }else if cityModel.resOpenInfo == "false" {
            openNowLbl.text = "Closed"
        }else {
            openNowLbl.text = ""
        }
        ratingImgView.image = getRatingStarImgFor(cityModel.resRating)
        
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: cityModel.resPlaceId) { (photo, error) in
            if error != nil {
                print("error: \(error?.localizedDescription)")
            }else {
                if let firstPhoto = photo?.results.first {
                    GMSPlacesClient.shared().loadPlacePhoto(firstPhoto, callback: { (image, error) in
                        if error != nil {
                            print("error: \(error?.localizedDescription)")
                        }else {
                            self.placeImg.image = image
                            self.placeImg.layer.cornerRadius = 8.0
                            self.placeImg.layer.masksToBounds = true
                        }
                    })
                }
            }
        }
        
    }
    
    func getRatingStarImgFor(_ rating: Double) -> UIImage? {
        let roundedRating = Double(Int(rating * 2 + 0.5))/2.0
        return UIImage(named: "star\(roundedRating).png")
    }
    
    
}
