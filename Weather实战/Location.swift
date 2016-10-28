//
//  Location.swift
//  Weather实战
//
//  Created by 樊树康 on 2016/10/6.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//


import Foundation

struct Location {

 private func configAccuracy() -> AMapLocationManager{
        let manager = AMapLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.locationTimeout = 3
        manager.reGeocodeTimeout = 3
        return manager
  }
    
    func configManager() -> AMapLocationManager  {
        let mapManager = configAccuracy()
        return mapManager
    }
    
    static let singleLocation = Location()
    func locationResult(mapManager:AMapLocationManager,closer_: (getRecode:AMapLocationReGeocode) -> ())
    {
        mapManager.requestLocationWithReGeocode(true)
        {
            (location, regeocode, error) in
            if ((error) != nil)
            {
                print("locError:\(error.code) - \(error.localizedDescription)")
            
                self.locationResult(mapManager, closer_: closer_)
            
                if(Int(error.code) == AMapLocationErrorCode.LocateFailed.rawValue)
        
                {
                return
                }
            }
            if (regeocode != nil)
            {
                closer_(getRecode: regeocode)
            }
 
        }
    }
}
