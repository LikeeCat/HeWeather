//
//  WeatherRealm.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/14.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import Foundation
import RealmSwift

class CityRealm: Object {
    
    dynamic var cityName = ""
    dynamic var Cnty = ""
    dynamic var id = ""
    dynamic var prov = ""
    dynamic var createdTime = NSDate()

    dynamic var pinYin = ""
    dynamic var firstLetter = ""
    override static func primaryKey() -> String? {
        return  "id"
    }
    
    
 
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
class LocationCityRealm: Object {
     var cityList = List<CityRealm>()
    
     static let customCityList =  LocationCityRealm()
}

class CustomCityList: Object {
    dynamic var city :CityRealm!
}
