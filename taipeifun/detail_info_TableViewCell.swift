//
//  detail_info_TableViewCell.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/5.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class detail_info_TableViewCell: UITableViewCell {

    @IBOutlet weak var session: UILabel!
    @IBOutlet weak var time_lab: UILabel!
    @IBOutlet weak var location_name_lab: UILabel!
    @IBOutlet weak var location_but: UIButton!
    @IBOutlet weak var price_lab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
