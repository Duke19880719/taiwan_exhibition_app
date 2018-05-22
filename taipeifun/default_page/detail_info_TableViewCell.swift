//
//  detail_info_TableViewCell.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/5.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

protocol get_touch {
    func pass_touch(_ touch:Int) -> Void
}

class detail_info_TableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBOutlet weak var session: UILabel!
    @IBOutlet weak var time_lab: UILabel!
    @IBOutlet weak var location_name_lab: UILabel!
    @IBOutlet weak var location_but: UIButton!
    var touch_index:Int?
    var protocol_passtouch:get_touch?
    
    func return_touch_index(index_temp:Int) {
        touch_index = index_temp
    }
    
    @IBAction func touch_who_get(_ sender: Any) {

        protocol_passtouch?.pass_touch(touch_index!)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
