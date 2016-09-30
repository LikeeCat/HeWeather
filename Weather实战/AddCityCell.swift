//
//  AddCityCell.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/16.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit

class AddCityCell: UITableViewCell {

  
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var ConstantLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    func cellForRowInAddCityCell(indexpath:NSIndexPath,tableView:UITableView)  {
       
        self.ConstantLabel.text = "添加城市"
        self.AddButton.imageView?.image = UIImage(named: "Add")
       
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
