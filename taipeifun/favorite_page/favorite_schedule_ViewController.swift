//
//  favorite_schedule_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/6.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class favorite_schedule_ViewController: UIViewController,get_touch {

    var rececive_data:[User_favorit_exibition]?
    var saleornot:String?
    var index_number:Int?
    var image_temp:UIImage?
  
    
    @IBOutlet weak var tableview: UITableView!
    
    func pass_touch(_ touch: Int) {
        index_number = touch
        performSegue(withIdentifier: "passtomap", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
//        tableview.layer.masksToBounds = true
//        tableview.layer.borderColor = UIColor.orange.cgColor
//        tableview.layer.borderWidth = 4
//        tableview.layer.cornerRadius = 10
//        tableview.layer.shadowColor = UIColor.black.cgColor
//        tableview.layer.shadowOffset = CGSize(width: 2, height: 2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var s =  rececive_data![0].detail_info?.allObjects as! [Detai_info]
        
        if segue.identifier == "passtomap"{
          
            if s[index_number!].latitude != nil && s[index_number!].longitude != nil {
                var map = segue.destination as! favorite_map_schedule_ViewController
                var Latitude_str:NSString = s[index_number!].latitude! as NSString
                var longitude_str:NSString = s[index_number!].longitude! as NSString
                map.Latitude = Latitude_str.doubleValue
                map.longitude = longitude_str.doubleValue
                map.exibit_location_name = s[index_number!].location_name
                map.exhibibt_location = s[index_number!].location
                map.map_image = image_temp
            }
            else{
                var map = segue.destination as! favorite_map_schedule_ViewController
                map.Latitude = 0
                map.longitude = 0
                map.exibit_location_name = s[index_number!].location_name
                map.exhibibt_location = s[index_number!].location
                map.map_image = image_temp
            }
//            if rececive_data![index_number!].latitude != nil && rececive_data![index_number!].longtitude != nil {
//                var map = segue.destination as! favorite_map_schedule_ViewController
//                var Latitude_str:NSString = rececive_data![index_number!].latitude! as NSString
//                var longitude_str:NSString = rececive_data![index_number!].longtitude! as NSString
//                map.Latitude = Latitude_str.doubleValue
//                map.longitude = longitude_str.doubleValue
//                map.exibit_location_name = rececive_data![index_number!].locationName
//                map.exhibibt_location = rececive_data![index_number!].location
//                map.map_image = image_temp
//            }
//            else{
//                var map = segue.destination as! favorite_map_schedule_ViewController
//                map.Latitude = 0
//                map.longitude = 0
//                map.exibit_location_name = rececive_data![index_number!].locationName
//                map.exhibibt_location = rececive_data![index_number!].location
//                map.map_image = image_temp
//            }
        }
    }
    
    
    
}
extension favorite_schedule_ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var s =  rececive_data![0].detail_info?.allObjects as! [Detai_info]
    
        if s != nil{
            return (s.count)
        }
//        if rececive_data != nil{
//            return (rececive_data?.count)!
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite_schedule_TableViewCell", for: indexPath) as! favorite_schedule_TableViewCell

//        cell.location_but.titleLabel?.lineBreakMode = .byWordWrapping
//        cell.session.text = "活動場次\(indexPath.row+1)"
//        if rececive_data![indexPath.row].endTime != ""{
//            cell.time_lab.text = "時間:\(rececive_data![indexPath.row].time!)－\(rececive_data![indexPath.row].endTime!)"
//        }
//        else{
//            cell.time_lab.text = "時間:\(rececive_data![indexPath.row].time!)"
//        }
//        cell.location_name_lab.text = "地點名稱：\(rececive_data![indexPath.row].locationName!)"
//        
//        let yourAttributes : [NSAttributedStringKey: Any] = [
//            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
//            NSAttributedStringKey.foregroundColor : UIColor.blue,
//            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
//        var atribute_str = NSMutableAttributedString(string: "\(String(describing: rececive_data![indexPath.row].location!))",
//            attributes:  yourAttributes)
//        if rececive_data![indexPath.row].location != "" && rececive_data![indexPath.row].location != nil{
//            cell.location_but.setAttributedTitle(atribute_str, for: .normal)
//        }
//        else{
//            cell.location_but.setTitle("無相關資訊", for: .normal)
//        }
//        cell.return_touch_index(index_temp: indexPath.row)
//        cell.protocol_passtouch = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! favorite_schedule_TableViewCell
        
        var s =  rececive_data![0].detail_info?.allObjects as! [Detai_info]

        cell.location_but.titleLabel?.lineBreakMode = .byWordWrapping
        cell.session.text = "活動場次\(indexPath.row+1)"
        
        if s[indexPath.row].end_time != "" {
            cell.time_lab.text = "\(s[indexPath.row].start_time!)－\(s[indexPath.row].end_time!)"
        }
   
        else{
            cell.time_lab.text = "\(s[indexPath.row].start_time!)"
        }
        cell.location_name_lab.text = "\(s[indexPath.row].location_name!)"
        
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor : UIColor.blue,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        var atribute_str = NSMutableAttributedString(string: "\(String(describing: s[indexPath.row].location!))",
            attributes:  yourAttributes)
        if s[indexPath.row].location != "" && s[indexPath.row].location != nil{
            cell.location_but.setAttributedTitle(atribute_str, for: .normal)
        }
        else{
            cell.location_but.setTitle("無相關資訊", for: .normal)
        }
        cell.return_touch_index(index_temp: indexPath.row)
        cell.protocol_passtouch = self
        
//        cell.location_but.titleLabel?.lineBreakMode = .byWordWrapping
//        cell.session.text = "活動場次\(indexPath.row+1)"
//        if rececive_data![indexPath.row].endTime != ""{
//            cell.time_lab.text = "時間:\(rececive_data![indexPath.row].time!)－\(rececive_data![indexPath.row].endTime!)"
//        }
//
//        else{
//            cell.time_lab.text = "時間:\(rececive_data![indexPath.row].time!)"
//        }
//        cell.location_name_lab.text = "地點名稱：\(rececive_data![indexPath.row].locationName!)"
//
//        let yourAttributes : [NSAttributedStringKey: Any] = [
//            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
//            NSAttributedStringKey.foregroundColor : UIColor.blue,
//            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
//        var atribute_str = NSMutableAttributedString(string: "\(String(describing: rececive_data![indexPath.row].location!))",
//            attributes:  yourAttributes)
//        if rececive_data![indexPath.row].location != "" && rececive_data![indexPath.row].location != nil{
//            cell.location_but.setAttributedTitle(atribute_str, for: .normal)
//        }
//        else{
//            cell.location_but.setTitle("無相關資訊", for: .normal)
//        }
//        cell.return_touch_index(index_temp: indexPath.row)
//        cell.protocol_passtouch = self
    }
    func sale_or_not(_ temp_str:String)  {
        
        if temp_str == "Y"{
            saleornot = "售票"
        }
            
        else if temp_str == "N"{
            saleornot = "免費"
        }
        
    }
    
    
    
}
