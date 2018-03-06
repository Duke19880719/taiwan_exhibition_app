//
//  display_info_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/2/21.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class display_info_ViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var exhib_image: UIImageView!
    @IBOutlet weak var title_lab: UILabel!
    @IBOutlet weak var unit_lab: UITextView!
    @IBOutlet weak var time_lab: UILabel!
    @IBOutlet weak var promote_source_web: UIButton!
    @IBOutlet weak var web_sale: UIButton!
    @IBOutlet weak var discount: UITextView!
    @IBOutlet weak var activity_info: UIButton!
    @IBOutlet weak var descript_info: UITextView!
    @IBOutlet weak var source_label: UILabel!
    
    var title_temp:String?
    var img_exhib:UIImage?
    var unit:String?
    var time_str:String?
    var source_web_str:String?
    var websale_str:String?
    var discount_str:String?
    var activity_str:String?
    var description_str:String?
    var saleornot_str:String?
    var promote_source_url:String?
    var detail_array:[display.ShowInfo]?
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\(detail_array!)")
        
        scrollview.bounces = false
        title_lab.text = title_temp!
        exhib_image.image = img_exhib!
        unit_lab.text = unit!
        time_lab.text = time_str!

//        source_web.setTitle(source_web_str!, for: .normal)
        source_label.text = "來源網站：\(source_web_str!)"
        activity_info.setTitle(activity_str!, for: .normal)
        discount.text = discount_str
        descript_info.text = description_str!
        
        
        
        if saleornot_str == "N"{
            web_sale.setTitle("免費,無販售網站", for: .normal)
        }
        else if saleornot_str == "Y" && saleornot_str! != ""{
            web_sale.setTitle("售票網站：\(websale_str!)", for: .normal)
        }
//        else{
//            web_sale.setTitle("無販售網站相關資訊", for: .normal)
//        }
        promote_source_web.layer.cornerRadius = 10
        activity_info.layer.cornerRadius = 10
        web_sale.layer.cornerRadius = 10
        
        title_lab.layer.masksToBounds = true
        title_lab.layer.cornerRadius = 10
        
        source_label.layer.masksToBounds = true
        source_label.layer.cornerRadius = 10
        
        exhib_image.layer.masksToBounds = true
        exhib_image.layer.cornerRadius = 20
        
        unit_lab.layer.masksToBounds = true
        unit_lab.layer.cornerRadius = 10
        
        time_lab.layer.masksToBounds = true
        time_lab.layer.cornerRadius = 10
        
        descript_info.layer.cornerRadius = 20
        discount.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sourceweb_segue"{
            var destain_surceweb = segue.destination as! sourceweb_ViewController
            destain_surceweb.sourceweb_url = promote_source_url
        }
        if segue.identifier == "sale_web_segue"{
            var destain_saleweb = segue.destination as! sale_web_ViewController
            destain_saleweb.sale_web_str = websale_str
        }
//        if segue.identifier == "detail_segue"{
//            var destain = segue.destination as! detail_info_ViewController
//            destain.rececive_data = detail_array
//        }
    }
    

}
