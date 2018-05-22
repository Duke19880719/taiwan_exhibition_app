//
//  CollectionViewCell.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/1/27.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
protocol change {
    func changelabel(change_word:String)
    func load_jsondata(url_path:String,change_word:String)
    
}
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menu_but: UIButton!
    var lab_str:String?
    var changeword:change?
    var urlstr1:String?
    //touch up inside
    
    func set_value(who_touch:String)  {
        lab_str = who_touch
    }
    @IBAction func but_action(_ sender: Any) {
       
        switch (lab_str) {
        case "展覽資訊"?:
              urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=6"
        case "獨立音樂資訊"?:
               urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=5"
        case "音樂資訊"?:
               urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=1"
        case "戲劇資訊"?:
               urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=2"
        case "舞蹈資訊"?:
               urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=3"
        case "電影資訊"?:
             urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=8"
        case "其他藝文資訊"?:
             urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=15"
        default:
            print("no value")
        }
        
        changeword?.changelabel(change_word: lab_str!)
        changeword?.load_jsondata(url_path: urlstr1!,change_word: lab_str!)
    }

    
}
