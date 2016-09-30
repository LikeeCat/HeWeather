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
    let timer = NSCalendar.currentCalendar()
    
    let date = NSDate()

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
               self.cond.text = succeed.first?.wind?.sc
                print(self.cond.text)
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
    
        let NowTime = timer.components([.Hour,.Minute,.Second], fromDate: date)
   
         let dateString = "\( NowTime.hour):\( NowTime.minute)"
       
        return dateString
    }
    
    
  
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
