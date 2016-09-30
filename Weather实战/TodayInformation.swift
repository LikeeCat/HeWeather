//
//  TodayInformation.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import Foundation

struct TodayInformation{
    //日出 日落
    var sr :String = " "
    var ss :String = " "
    //降水概率 降水量
    var pop:String = " "
    var pcpn: String = " "
    //湿度(%)
    var hum: String = " "
    //风速(Kmph)
    var spd: String = " "
     // 风力等级
    var sc :String = " "
    //风向(方向)
    var dir:String = " "
   // 气压
    var pres :String = " "
    //能见度(km)
   
    var vis :String = " "
   
       static let rows = 5
    static let weatherInformationkeyArray = ["日出","日落","降水概率","降水量","湿度","风速","风力等级","风向","气压","能见度"]
}


struct Costant {
    let humConstant = "%"
    let pcpnConstant = "mm"
    let spdConstant = "Kmph"
    let visConstant =  "km"
    let tailSymbol = ":"
    
}
