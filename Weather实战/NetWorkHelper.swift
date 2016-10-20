//
//  NetWorkHelper.swift
//  Weather实战
//
//  Created by 懒懒的猫鼬鼠 on 16/8/26.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//
import SwiftyJSON
import Alamofire
import Foundation
import ObjectMapper
import RealmSwift
class  NetWorkHelper {
    
    static let netWorkHelper = NetWorkHelper()

    func fetch(cityID:String?, clouser:(succeed:[Daily],responseValue:JSON) -> Void){
       if let name = cityID {
        
        let  paramterd = person.cityID + "=" + name + "&" + person.key + "=" + person.KeyValue
        let url = person.BaseURL + paramterd
        print(url, terminator: "")
        Alamofire.request(.GET, url).validate().responseJSON { respon in
            let jsonValue = JSON(respon.result.value!)
            if let dic = respon.result.value as? NSDictionary {
                
                 if let newDic = dic["HeWeather data service 3.0"]?.firstObject as? NSDictionary{
                    
                       if let weatherArray = newDic["daily_forecast"] as? NSArray{
                      
                        let daily = Mapper<Daily>().mapArray(weatherArray)
                        clouser(succeed: daily!, responseValue:jsonValue)
                   
                        }
                 
                   }
               
               }
        
       
          }
        
    
      }
    }
    
    //MARK: SaveCity With Realm DataBase
    
    func fetchAllCity(city:String?, clouser:(succeed:List<CityRealm>, responseValue:JSON) -> Void){
    
        
            if let fetchCity = city {
                
                let  paramterd = person.SearchCity + "=" + fetchCity + "&" + person.key + "=" + person.KeyValue
      
                let url = person.BaseCityURL + paramterd
                
                print(url, terminator: "")

                Alamofire.request(.GET, url).validate().responseJSON { respon in
                  //  print(respon.result.value)
                    let jsonValue = JSON(respon.result.value!)
                    let jsonCity = jsonValue["city_info"].arrayValue
                    let cityArray = List<CityRealm>()
                    
                    for json in jsonCity{
                        
                        let realmCity = CityRealm()
                       
                        let pinYin = json["city"].stringValue
                        realmCity.cityName = json["city"].stringValue
                        realmCity.Cnty = json["cnty"].stringValue
                        realmCity.id = json["id"].stringValue
                        realmCity.prov = json["prov"].stringValue
                        realmCity.pinYin = String.transfromChineseToWord(pinYin).pinYin
                        realmCity.firstLetter = String.transfromChineseToWord(pinYin).firstLetter
                         cityArray.append(realmCity)
                       
 
                        }
                   print(cityArray.count)
                 
                    clouser(succeed: cityArray, responseValue: jsonValue)
                


              }
   
            }
    }

}

struct person {
    static let cityID = "cityid"
    static let key = "key"
    static let KeyValue = "7b7b2605e91d46a19f1eaa79394435bc"
    static let BaseURL = "https://api.heweather.com/x3/weather?"
    static let BaseCityURL = "https://api.heweather.com/x3/citylist?"
    static let SearchCity = "search"

    static let WeatherImageBaseURL = "http://files.heweather.com/cond_icon/"
    static let WeatherImageTail = ".png"
    
    static let GaodeAPIKey = "284589c0cade4061ba3092fff3367b37"

}
