//
//  CityModel.swift
//  FindResturent
//
//  Created by Md AfzaL Hossain on 3/22/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import Foundation


class CityModel {
    private var _resName: String!
    private var _resAddress: String!
    private var _resOpenInfo: String!
    private var _resRating: Double!
    private var _resPlaceId: String!
    
    var resName: String {
        if _resName == nil {
            _resName = ""
        }
        return _resName
    }
    var resAddress: String {
        if _resAddress == nil {
            _resAddress = ""
        }
        return _resAddress
    }
    var resOpenInfo: String {
        if _resOpenInfo == nil {
            _resOpenInfo = ""
        }
        return _resOpenInfo
    }
    var resRating: Double {
        if _resRating == nil {
            _resRating = 0
        }
        return _resRating
    }
    var resPlaceId: String {
        if _resPlaceId == nil {
            _resPlaceId = ""
        }
        return _resPlaceId
    }
    
    
    init(name: String,address: String,openInfo: String,rating: Double,placeId: String) {
        self._resName = name
        self._resAddress = address
        self._resOpenInfo = openInfo
        self._resRating = rating
        self._resPlaceId = placeId
    }
  
}
