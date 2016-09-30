//
//  SuggestCell.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit

class SuggestCell: UITableViewCell {

    @IBOutlet weak var Today: UILabel!
    @IBOutlet weak var suggestInformation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
