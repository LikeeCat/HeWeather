//
//  APIModel.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/6.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherModel: Mappable {
    var basic:Basic?
    var status = ""
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
    
        status <- map["status"]
        basic <- map["basic"]
    }
}


class Basic: Mappable {
    var city:String = ""
    var cnty:String = ""
    var id = ""
    var lat = ""
    var lon = ""
    var update:[String:String]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        city <- map["city"]
        cnty <- map["cnty"]
        id <- map["id"]
        lat <- map["lat"]
        lon <- map["lon"]
        update <- map["update"]
        
    }

}


//MARK: weekWeatherModel
//class DailyForecast:Mappable{
//    var daily:Daily?
//    required init?(_ map: Map) {
//        
//    }
//     func mapping(map: Map) {
//        daily <- map["daily_forecast"]
//    }
//}
class Daily: Mappable {
    var astro:Astro?
    var cond:Cond?
    var date = ""
    var hum = ""
    var pcpn = ""
    var pop = ""
    var pres = ""
    var tmp :Tmp!
    var vis = ""
    var wind:Wind?
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
      astro <- map["astro"]
      cond <- map["cond"]
      date <- map["date"]
      hum <- map["hum"]
      pcpn <- map["pcpn"]
      pop <- map["pop"]
      pres <- map["pres"]
      tmp <- map["tmp"]
      vis <- map["vis"]
      wind <- map["wind"]
    }
}

class Astro:Mappable  {
    var sr = ""
    var ss = ""
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        sr <- map["sr"]
        ss <- map["ss"]
        
    }
    
}
class Cond: Mappable {
   var code_d = ""
   var code_n = ""
   var txt_d = ""
   var txt_n = ""
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        code_d <- map["code_d"]
        code_n <- map["code_n"]
        txt_d <- map[" txt_d"]
        txt_n <- map["txt_n"]
        
    }
}

class Tmp: Mappable {
    var max = ""
    var min = ""
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        max <- map["max"]
        min <- map["min"]
        
    }

    
}
class Wind:Mappable{
   var deg = ""
   var dir = ""
   var sc = ""
   var spd = ""
    required init?(_ map: Map) {
        
    }
     func mapping(map: Map) {
        deg <- map["deg"]
        dir <- map["dir"]
        sc <- map["sc"]
        spd <- map["spd"]


        
    }
    
}

class CityInfo:Mappable{
    var city = " "
    var cnty = " "
    var id = " "
    var lat = " "
    var lon = " "
    var prov = " "
    required init?(_ map: Map) {
        
    }
     func mapping(map: Map) {
      city <- map["city"]
      cnty <- map["cnty"]
      id <- map["id"]
      lat <- map["lat"]
      lon <- map["lon"]
      prov <- map["prov"]
        
    }
    
}