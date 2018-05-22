//
//  custom_search_detail_info_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/12.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import CoreData

class custom_search_detail_info_ViewController: UIViewController {

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
    var favorite_exhibit:User_favorit_exibition!
    var favorite_deatail_info:Detai_info!
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func favorite_add(_ sender: Any) {
        var favorite_exhibit:User_favorit_exibition!
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            favorite_exhibit = User_favorit_exibition(context:appdelegate.persistentContainer.viewContext)
            favorite_exhibit.activity_str = activity_str
            favorite_exhibit.description_str = description_str
            favorite_exhibit.discount_str = discount_str
            favorite_exhibit.endTime = detail_array![0].endTime
            
            if let img_check = img_exhib{
                if let imgdata = UIImagePNGRepresentation(img_check){
                    favorite_exhibit.img_exhib = NSData(data:imgdata) as Data
                }
            }
            
//            favorite_exhibit.latitude = detail_array![0].latitude
//            favorite_exhibit.longtitude = detail_array![0].longitude
            favorite_exhibit.location = detail_array![0].location
//            favorite_exhibit.locationName = detail_array![0].locationName
            

            favorite_exhibit.onSales = detail_array![0].onSales
            favorite_exhibit.price = detail_array![0].price
            favorite_exhibit.promote_source_url = promote_source_url
            favorite_exhibit.saleornot_str = saleornot_str
            favorite_exhibit.source_web_str = source_web_str
            favorite_exhibit.time = detail_array![0].time
            favorite_exhibit.time_str = time_str
            favorite_exhibit.title_temp = title_temp
            favorite_exhibit.unit = unit
            favorite_exhibit.websale_str = websale_str
            
            if detail_array?.count != nil && (detail_array?.count)! >= 0{
                
                for i in 0...(detail_array?.count)!-1{
                    favorite_deatail_info = Detai_info(context:appdelegate.persistentContainer.viewContext)
                    favorite_deatail_info.latitude = detail_array![i].latitude
                    favorite_deatail_info.longitude = detail_array![i].longitude
                    favorite_deatail_info.start_time = detail_array![i].time
                    favorite_deatail_info.end_time = detail_array![i].endTime
                    favorite_deatail_info.location = detail_array![i].location
                    favorite_deatail_info.location_name = detail_array![i].locationName
                    favorite_exhibit.addToDetail_info(favorite_deatail_info)
                    appdelegate.saveContext()
                }
            }
            
            appdelegate.saveContext()
            
            var alert_controller = UIAlertController(title: "提示資訊", message: "已將該筆資料夾入到\"我的最愛\"", preferredStyle: UIAlertControllerStyle.alert)
            
            var ok_but = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil)
            alert_controller.addAction(ok_but)
            present(alert_controller, animated: true, completion:nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(detail_array![0].latitude)
        scrollview.bounces = false
        title_lab.text = title_temp!
        exhib_image.image = img_exhib!
        if unit != nil{
            unit_lab.text = unit!
        }
        else{
            unit_lab.text = "無相關資料"
        }
        
        time_lab.text = time_str!
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
            var destain_surceweb = segue.destination as! custom_search_promote_web_ViewController
            destain_surceweb.sourceweb_url = promote_source_url
            
        }
        if segue.identifier == "sale_web_segue"{
            var destain_saleweb = segue.destination as! custom_search_sale_web_ViewController
            destain_saleweb.sale_web_str = websale_str
        }
        if segue.identifier == "detail_segue"{
            var destain = segue.destination as! custom_search_schedule_info_ViewController
            destain.rececive_data = detail_array
            destain.image_temp = img_exhib
        }
    }
}
