//
//  AddCityCell.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit
import RealmSwift

class locationCityCell: UITableViewCell {
    
    let date = NSDate()
    
    var srDate:NSDate!
    var ssDate:NSDate!
    @IBOutlet weak var cond: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateUI(city: CityRealm)  {
        
            NetWorkHelper.netWorkHelper.fetch(city.id, clouser: { (succeed, _) in
                
                let dateString = (succeed.first?.date)! + " "
                
                let srDateString = dateString + (succeed.first?.astro?.sr)!
                
                let ssDateString = dateString + (succeed.first?.astro?.ss)!
                let dateSet = DateOperation.operation.getSunriseAndSet(srDateString, sunset: ssDateString)
                self.srDate = dateSet.0
                self.ssDate = dateSet.1
                print(succeed.first?.cond?.txt_d)
                if DateOperation.operation.isDay(self.date, srDate: self.srDate, ssDate: self.ssDate){
                    self.cond.text = succeed.first?.cond?.txt_d
                
                }else{
                    self.cond.text = succeed.first?.cond?.txt_n

                }
                

                self.temp.text = "\((succeed.first?.tmp.min)!)℃/\((succeed.first?.tmp.max)!)℃"
            })
        }
    
    
    func cellForRowInlocationCityCell(indexpath:NSIndexPath,tableView:UITableView,r: [CityRealm]){
        let city  = r[indexpath.row]
        self.updateUI(city)

        self.location.text = city.cityName
    
        self.time.text = getTime(date)

    }

    func getTime(date:NSDate) -> String {
    
        let dateFormatter =  NSDateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
        
        let dateString = dateFormatter.stringFromDate(date);
       
        return dateString
    }
    
    
  
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
