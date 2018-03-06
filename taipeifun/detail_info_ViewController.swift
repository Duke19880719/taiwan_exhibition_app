//
//  detail_info_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/5.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class detail_info_ViewController: UIViewController,pass_data_detail {
    var rececive_data:[display.ShowInfo]?
    func pass_data(data: [display.ShowInfo]) {
        print(1111)
        self.rececive_data = data
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var vc = ViewController()
        vc.pass_data = self
        
        print(rececive_data)
        tableview.layer.masksToBounds = true
        tableview.layer.borderColor = UIColor.orange.cgColor
        tableview.layer.borderWidth = 4
        
        tableview.layer.cornerRadius = 10
        
        tableview.layer.shadowColor = UIColor.black.cgColor
        tableview.layer.shadowOffset = CGSize(width: 2, height: 2)
        
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension detail_info_ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rececive_data != nil{
            return (rececive_data?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail_cell", for: indexPath) as! detail_info_TableViewCell
        cell.session.text = "活動場次\(indexPath.row+1)"
        cell.time_lab.text = "時間:\(rececive_data![indexPath.row].time!)－\(rececive_data![indexPath.row].endTime!)"
        cell.location_name_lab.text = "地點名稱：\(rececive_data![indexPath.row].locationName!)"
        cell.location_but.titleLabel?.text = rececive_data![indexPath.row].location
//        cell.location_but.setTitle(rececive_data![indexPath.row].location, for: .normal)
        cell.price_lab.text = "\(rececive_data![indexPath.row].onSales!),價格：\(rececive_data![indexPath.row].price!)"
        
        return cell
    }

}
