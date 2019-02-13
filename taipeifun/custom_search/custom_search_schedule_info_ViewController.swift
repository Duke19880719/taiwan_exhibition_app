//
//  custom_search_schedule_info_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/12.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class custom_search_schedule_info_ViewController: UIViewController,get_touch {
    var rececive_data:[display.ShowInfo]?
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

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passtomap"{
            if rececive_data![index_number!].latitude != nil && rececive_data![index_number!].longitude != nil {
                var map = segue.destination as! custom_search_schedule_map_ViewController
                var Latitude_str:NSString = rececive_data![index_number!].latitude! as NSString
                var longitude_str:NSString = rececive_data![index_number!].longitude! as NSString
                map.Latitude = Latitude_str.doubleValue
                map.longitude = longitude_str.doubleValue
                map.exibit_location_name = rececive_data![index_number!].locationName
                map.exhibibt_location = rececive_data![index_number!].location
                map.map_image = image_temp
            }
            else{
                var map = segue.destination as! custom_search_schedule_map_ViewController
                map.Latitude = 0
                map.longitude = 0
                map.exibit_location_name = rececive_data![index_number!].locationName
                map.exhibibt_location = rececive_data![index_number!].location
                map.map_image = image_temp
            }
        }
    }
    
    
    
}
extension custom_search_schedule_info_ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rececive_data != nil{
            return (rececive_data?.count)!
        }
        return 0
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_search_schedule_info_TableViewCell", for: indexPath) as! custom_search_schedule_info_TableViewCell
        

        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! custom_search_schedule_info_TableViewCell
        
        //cell animate
        let cell_transform = CATransform3DTranslate(CATransform3DIdentity, 1000, 0, 1000)
        
        cell.layer.transform = cell_transform
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
        }
        //cell ui design
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.alpha = 1
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        
        cell.location_but.titleLabel?.lineBreakMode = .byWordWrapping
        cell.session.text = "活動場次\(indexPath.row+1)"
        if rececive_data![indexPath.row].endTime != ""{
            cell.time_lab.text = "\(rececive_data![indexPath.row].time!)－\(rececive_data![indexPath.row].endTime!)"
        }
        else{
            cell.time_lab.text = "\(rececive_data![indexPath.row].time!)"
        }
        cell.location_name_lab.text = "\(rececive_data![indexPath.row].locationName!)"
        
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor : UIColor.blue,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        var atribute_str = NSMutableAttributedString(string: "\(String(describing: rececive_data![indexPath.row].location!))",
            attributes:  yourAttributes)
        if rececive_data![indexPath.row].location != "" && rececive_data![indexPath.row].location != nil{
            cell.location_but.setAttributedTitle(atribute_str, for: .normal)
        }
        else{
            cell.location_but.setTitle("無相關資訊", for: .normal)
        }
        cell.return_touch_index(index_temp: indexPath.row)
        cell.protocol_passtouch = self
 
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
