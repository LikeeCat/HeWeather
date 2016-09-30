//
//  CustomCell.swift
//  Weather实战
//
//  Created by 樊树康 on 16/8/24.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {



    @IBOutlet weak var BgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
 
        self.BgView.layer.cornerRadius = 10
        self.BgView.layer.shadowColor = UIColor.redColor().CGColor
        self.BgView.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.BgView.layer.shadowRadius = 5.0
        //不透明
       
        self.BgView.layer.shadowOpacity = 0.5
        
      
        
    }



}
