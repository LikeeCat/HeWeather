//
//  InformationCell.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit

class InformationCell: UITableViewCell {
    
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var key1: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var key: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
//    func cellForRowAtIndexPath(tableView:UITableView,indexPath:NSIndexPath,model:TodayInformation) -> InformationCell{
//        let cell = tableView.dequeueReusableCellWithIdentifier("informationCell", forIndexPath: indexPath) as! InformationCell
//        switch indexPath.row
//        {
//        case 0:
//            cell.key .text = TodayInformation.weatherInformationkeyArray[0]+Costant.tailSymbol
//            cell.value.text = model.sr
//            cell.key1.text = TodayInformation.weatherInformationkeyArray[1]+Costant.tailSymbol
//            cell.value1.text = model.ss
//        case 1:
//            cell.key .text = TodayInformation.weatherInformationkeyArray[2]+constant.tailSymbol
//            
//            cell.value.text = model.pop + Costant.humConstant
//            cell.key1.text = TodayInformation.weatherInformationkeyArray[3]+constant.tailSymbol
//            
//            cell.value1.text = model.pcpn + constant.pcpnConstant
//            
//        case 2:
//            cell.key .text = TodayInformation.weatherInformationkeyArray[4]+constant.tailSymbol
//            
//            cell.value.text = model.hum + constant.humConstant
//            cell.key1.text = TodayInformation.weatherInformationkeyArray[5]+constant.tailSymbol
//            
//            cell.value1.text = todayInformation.spd + constant.spdConstant
//        case 3:
//            cell.key .text = TodayInformation.weatherInformationkeyArray[6]+constant.tailSymbol
//            
//            cell.value.text = model.sc
//            cell.key1.text = TodayInformation.weatherInformationkeyArray[7]+constant.tailSymbol
//            
//            cell.value1.text = model.dir
//        case 4:
//            cell.key .text = TodayInformation.weatherInformationkeyArray[8]+constant.tailSymbol
//            
//            cell.value.text = model.pres
//            cell.key1.text = TodayInformation.weatherInformationkeyArray[9]+constant.tailSymbol
//            
//            cell.value1.text = todayInformation.vis + constant.visConstant
//        default:
//            break
//        }
//        
//        return cell
//
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
