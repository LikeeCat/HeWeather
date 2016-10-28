//
//  DateOperation.swift
//  Weather实战
//
//  Created by 樊树康 on 2016/10/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import Foundation


class DateOperation {
    
    let calendar = NSCalendar.currentCalendar()
    
    static let operation = DateOperation()
    

    
    func getSunriseAndSet(sunrise:String,sunset:String) -> (NSDate,NSDate) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYY-MM-dd HH:mm"
        
        let srDate = dateFormatter.dateFromString(sunrise)
        
        let ssDate = dateFormatter.dateFromString(sunset)
        
        return(srDate!,ssDate!)
    }
    
    
    func isDay(nowDate:NSDate,srDate:NSDate,ssDate:NSDate)->Bool{
        if ((srDate.compare(nowDate) == .OrderedAscending || srDate.compare(nowDate) == .OrderedSame) && (nowDate.compare(ssDate) == .OrderedAscending) ) {
            return true
        }
        else{
            return false
        }
    }
    
    func setWeekday(today:NSDate) ->[String]
    {
        
        var weekArray =  ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]

        let dateComp = calendar.components([.Weekday], fromDate: today)
        if weekArray[dateComp.weekday - 1] != "今天" {
            weekArray[dateComp.weekday - 1] = "今天"

        }
        var deleyeArray = [String]()
        for index in 0..<(dateComp.weekday - 1)
        {
            deleyeArray.append(weekArray.removeFirst())
        }
            
        return weekArray+deleyeArray
        
    }

}
