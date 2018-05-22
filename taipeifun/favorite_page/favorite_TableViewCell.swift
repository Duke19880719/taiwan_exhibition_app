//
//  favorite_TableViewCell.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/12.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class favorite_TableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBOutlet weak var echibit_img: UIImageView!
    @IBOutlet weak var exhibit_name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location_sale: UILabel!
    @IBOutlet weak var index_display: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
