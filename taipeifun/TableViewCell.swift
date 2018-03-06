//
//  TableViewCell.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/1/15.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

 
    @IBOutlet weak var lab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
