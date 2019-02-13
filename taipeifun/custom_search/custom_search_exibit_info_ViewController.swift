//
//  custom_search_exibit_info_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/12.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit


class custom_search_exibit_info_ViewController: UIViewController {
    var select_activity_str:String?
    var select_saleornot_str:String?
    var select_startday_str:String?
    var select_endday_str:String?
    var select_area_str:String?
    var input_textfield_str:String = ""
    var url:String?
    var city:[String] = [
        "新竹市","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","宜蘭縣","花蓮縣"
        ,"澎湖縣","基隆市","新竹市","嘉義市","新北市","桃園市","高雄市","新竹縣","澎湖縣","金門縣","連江縣","花蓮市"]
    var alert_controller = UIAlertController(title: "資料下載中", message: "\n\n\n", preferredStyle: UIAlertControllerStyle.alert)
    var check_alert:Bool = false
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var data_count_but: UIBarButtonItem!
    
    var alert_str:String?
    var temp_str:String?
    var temp_i:Int = 0
    var data1:[display] = []
    var url1:URL?
    var currentSession:URLSession?
    var saleornot:String?
    var img:UIImage?
    var temp_price:String = ""
    var check_viewdidappear:Bool = false
    var music_data:[display]?

    override func viewDidLoad() {
        super.viewDidLoad()


        load_json(load_url: url!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        check_viewdidappear = true
        if self.check_alert == false{
            var alert_activity = UIActivityIndicatorView(frame:self.alert_controller.view.bounds)
            alert_activity.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            alert_activity.color = UIColor.blue
            alert_activity.startAnimating()
            self.alert_controller.view.addSubview(alert_activity)
            self.present(self.alert_controller, animated: true, completion: nil)
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        data1 = []
        tableview.setContentOffset(tableview.contentOffset, animated: false)
        self.dismiss(animated: true, completion: nil)
    }
  
}



extension custom_search_exibit_info_ViewController{
    func load_json(load_url:String)  {
    
        url1 = URL(string: load_url)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: self ,
                                 delegateQueue: OperationQueue.main)
        
        let request = URLRequest(url: url1!)
        
        let dataTask =  session.downloadTask(with:request)
        
        dataTask.resume()
     
        
    }
}

extension custom_search_exibit_info_ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data1 != nil{
            return (data1.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var location_str:String = ""
        
        let table_cell = tableView.dequeueReusableCell(withIdentifier: "custom_search_exibit_info_TableViewCell", for: indexPath) as! custom_search_exibit_info_TableViewCell
        
        return table_cell
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var location_str:String = ""
        let table_cell = cell as! custom_search_exibit_info_TableViewCell
        //設置圖片圓形
        table_cell.echibit_img.clipsToBounds = true
        
        table_cell.echibit_img.layer.cornerRadius = 10
        
        //cell animate
        let cell_transform = CATransform3DTranslate(CATransform3DIdentity, 1000, 0, 1000)
        
        table_cell.layer.transform = cell_transform
        
        UIView.animate(withDuration: 0.75) {
            table_cell.layer.transform = CATransform3DIdentity
        }
        //cell ui design
        table_cell.layer.backgroundColor = UIColor.white.cgColor
        table_cell.alpha = 0.65
        
        table_cell.layer.cornerRadius = 10
        table_cell.clipsToBounds = true
        
        
        if data1[indexPath.row].imageUrl != "" && data1[indexPath.row].imageUrl != nil {
            let url = URL(string: data1[indexPath.row].imageUrl!)
            var data2 = try? Data(contentsOf: url!)
            if data2 != nil{
                var temp_img:UIImage = resizeImage(originalImg: UIImage(data: data2!)!)
                
                table_cell.echibit_img.image = UIImage(data: data2!)
            }
            else{
                table_cell.echibit_img.image = #imageLiteral(resourceName: "no_image_url")
            }
        }
        else{
            table_cell.echibit_img.image = #imageLiteral(resourceName: "no_image_url")
        }
        table_cell.exhibit_name.text = data1[indexPath.row].title
        
        if data1[indexPath.row].showInfo!.count == 1{
            location_str = city_finf(location1: data1[indexPath.row].showInfo![0].location!)
        }
        else if  data1[indexPath.row].showInfo!.count>1{
            location_str = city_finf(location1: data1[indexPath.row].showInfo![0].location!) + ",其他地點"
        }
        
        table_cell.time.text = "\((data1[indexPath.row].startDate)!)-\((data1[indexPath.row].endDate)!) "
        
        if data1[indexPath.row].showInfo!.count > 0 ,data1[indexPath.row].showInfo![0].onSales != ""{
            sale_or_not(data1[indexPath.row].showInfo![0].onSales!)
        }
        
        if temp_str == "" {
            temp_str = "無相關資訊"
        }
        if saleornot == "" ||  saleornot == nil{
            saleornot = "無相關資訊"
        }
        
        table_cell.location_sale.text = "\(location_str)"
        if saleornot == "售票"{
            table_cell.saleornot_lab.textColor = UIColor.red
            table_cell.saleornot_lab.text = saleornot!
        }
        else if saleornot == "免費"{
            table_cell.saleornot_lab.textColor = UIColor.orange
            table_cell.saleornot_lab.text = saleornot!
        }
        
        if data1.count > 0 {
            data_count_but.title = "\(data1.count)筆"
        }
        else{
            data_count_but.title = "0 筆"
        }
        table_cell.index_display.text = String(indexPath.row + 1)
    }
    
    func city_finf(location1:String) -> String  {
        var city:[String] = [
            "新竹市","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","宜蘭縣","花蓮縣"
            ,"澎湖縣","基隆市","新竹市","嘉義市","新北市","桃園市","高雄市","新竹縣","澎湖縣","金門縣","連江縣","花蓮市","嘉義縣","屏東市"]
        temp_str = nil
        
        for i in 0...city.count-1
        {
            if  (location1.range(of:"臺北市") != nil) || (location1.range(of:"台北市") != nil) {
                temp_str = "台北市"
            }
            else if   (location1.range(of:"臺中市") != nil) || (location1.range(of:"台中市") != nil){
                temp_str = "台中市"
            }
            else if   (location1.range(of:"臺南市") != nil) || (location1.range(of:"台南市") != nil) {
                temp_str = "台南市"
            }
            else if  (location1.range(of:"臺東縣") != nil) || (location1.range(of:"台東縣") != nil)  {
                temp_str = "台東縣"
            }
            else if (location1.range(of:city[i]) != nil)  {
                self.temp_str = city[i]
            }
            else if location1 == nil || location1 == "" {
                temp_str = "無所在地資訊"
            }
          
        }
        if temp_str == nil{
            temp_str = "\(location1)"
        }
       
        return temp_str!
    }
    func sale_or_not(_ temp_str:String)  {
        
        if temp_str == "Y"{
            saleornot = "售票"
            
        }
            
        else if temp_str == "N"{
            saleornot = "免費"
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "passto"
        {
            //        let destVC = segue.destination as! UINavigationController
            //        let slideVC = destVC.topViewController as! ViewControllerSlide
            
            
            var tran_obj = segue.destination as! custom_search_detail_info_ViewController
            
            
            tran_obj.promote_source_url = data1[(tableview.indexPathForSelectedRow?.row)!].sourceWebPromote
            
            
            tran_obj.detail_array = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo!
            
            
            if  data1[(tableview.indexPathForSelectedRow?.row)!].showInfo!.count > 0{
                print()
                var  ggy:Int = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo!.count
                
                temp_price =  data1[(tableview.indexPathForSelectedRow?.row)!].showInfo![0].price!
            }
            
            tran_obj.title_temp = "\(data1[(tableview.indexPathForSelectedRow?.row)!].title!)"
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].imageUrl != "" {
                let url = URL(string: data1[(tableview.indexPathForSelectedRow?.row)!].imageUrl!)
                var data2 = try? Data(contentsOf: url!)
                tran_obj.img_exhib = UIImage(data: data2!)
            }
            else{
                tran_obj.img_exhib = #imageLiteral(resourceName: "no_image_url")
            }
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].descriptionFilterHtml != ""{
                tran_obj.description_str = "簡介：\n\(data1[(tableview.indexPathForSelectedRow?.row)!].descriptionFilterHtml!)"
            }
            else{
                tran_obj.description_str = "無簡介相關資訊"
            }
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].startDate != ""{
                tran_obj.time_str = "展出時間：\(String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].startDate!)) - \(String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].endDate!))"
            }
            else{
                tran_obj.time_str = "無時間相關資訊"
            }
            
            var seprator = NSCharacterSet(charactersIn: "[]\"()中華民國null")
            var recevie_masterunit:String =  String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].masterUnit!)
            var recevie_shownunit:String =  String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].showUnit!)
            var complete_showunit_str = recevie_shownunit.components(separatedBy: seprator as CharacterSet)
            
            var complete_masterunit_str = recevie_masterunit.components(separatedBy: seprator as CharacterSet)
            
            var temp_location:String?
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].showInfo!.count > 0{
                if data1[(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location != "" || data1[(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location != nil{
                    temp_location = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location!
                }
                else {
                    temp_location = "無地點相關資訊"
                }
            }
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].masterUnit?.count != 0 && complete_showunit_str[0] != ""{
                if data1[(tableview.indexPathForSelectedRow?.row)!].showInfo?.count == 1 {
                    tran_obj.unit = "表演單位：\(complete_showunit_str[0])\t主辦單位：\(complete_masterunit_str[0])\n地點：\(temp_location!)"
                }
                if let temp_str1 = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo?.count,temp_str1 > 1{
                    tran_obj.unit = "表演單位：\(complete_showunit_str[0])\t主辦單位：\(complete_masterunit_str[0])\n地點：\(temp_location!),其他地點詳見場次資訊"
                }
            }
            else{
                
                if data1[(tableview.indexPathForSelectedRow?.row)!].showInfo?.count == 1 {
                    tran_obj.unit = "表演單位：無相關資訊\t主辦單位：無相關資訊\n地點：\(temp_location!)"
                }
                if let temp_str1 = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo?.count,temp_str1 > 1{
                    tran_obj.unit = "表演單位：無相關資訊\t主辦單位：無相關資訊\n地點：\(temp_location!),其他地點詳見場次資訊"
                }
                
            }
            
            tran_obj.source_web_str = "\(String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].sourceWebName!))"
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].webSales != ""{
                tran_obj.websale_str = "\(String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].webSales!))"
            }
            else{
                tran_obj.websale_str = "無相關資訊"
            }
            
            var seprator0 = NSCharacterSet(charactersIn: "<>br/")
            var recevie_discount:String =  String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].discountInfo!)
            var complete_discount_str = recevie_discount.components(separatedBy: seprator0 as CharacterSet)
            
            var seprator1 = NSCharacterSet(charactersIn: "<>br/[]\"")
            var receive_price:String = temp_price
            var complete_price = receive_price.components(separatedBy: seprator1 as CharacterSet)
            
            if data1[(tableview.indexPathForSelectedRow?.row)!].discountInfo != ""{
                if temp_price != ""{
                    tran_obj.discount_str = "票價：\n\(complete_price[0])\n\n折扣資訊：\n\(complete_discount_str[0])"
                    temp_price = ""
                }
                else{
                    tran_obj.discount_str = "票價：\n無票價資訊\n\n折扣資訊：\n\(complete_discount_str[0])"
                    temp_price = ""
                }
            }
            else{
                if temp_price != ""{
                    tran_obj.discount_str = "票價：\n\(complete_price[0])\n\n折扣資訊：\n無折扣相關資訊"
                    temp_price = ""
                }
                else{
                    tran_obj.discount_str = "票價：\n無票價資訊\n\n折扣資訊：\n無折扣相關資訊"
                    temp_price = ""
                }
            }
            
            if let count_show = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo?.count ,count_show > 0{
                tran_obj.saleornot_str = data1[(tableview.indexPathForSelectedRow?.row)!].showInfo![0].onSales!
            }
            else{
                tran_obj.saleornot_str = "no value"
            }
            tran_obj.activity_str = "活動場次：\(String(describing: data1[(tableview.indexPathForSelectedRow?.row)!].showInfo!.count))場,點擊查看詳細資訊"
            
        }
        
    }
}

extension custom_search_exibit_info_ViewController:URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var tem_data:Data?
        let decoder = JSONDecoder()
        tem_data = try! Data(contentsOf: location)
        decoder.dateDecodingStrategy = .iso8601
        
        if let data2 = tem_data, let Results = try?
            decoder.decode([display].self, from: data2)
        {
            print("succes")

            for i in 0...Results.count-1
            {
                var result_startday = Results[i].startDate?.toDateTime()
                var result_endday = Results[i].endDate?.toDateTime()
                var select_statday = select_startday_str?.toDateTime()
                var select_endday = select_endday_str?.toDateTime()

                //search
                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                    print("\(input_textfield_str)\n1")
                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                        self.data1.append(Results[i])
                    }
                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                        self.data1.append(Results[i])
                    }
                    else{
                         print("error")
                    }
                }
                //100 入 日 地
                if select_endday == nil && select_statday == nil && select_area_str == nil{

                        switch select_saleornot_str{
                        case "收費"?:
                            if (Results[i].showInfo?.count)! > 0 {
                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else{
                                        print("error")
                                    }
                                }
                                else if Results[i].showInfo![0].onSales == "Y"{
                                    self.data1.append(Results[i])
                                }
                            }

                        case "免費"?:
                            if (Results[i].showInfo?.count)! > 0 {
                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else{
                                        print("error")
                                    }
                                }
                                else if Results[i].showInfo![0].onSales == "N"{
                                    self.data1.append(Results[i])
                                }
                            }
                        case "兩者皆有"?:
                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                    self.data1.append(Results[i])
                                }
                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                    self.data1.append(Results[i])
                                }
                            }
                            else{
                                self.data1.append(Results[i])
                            }
                        default:
                            print("error")
                        }
                }

                //101 入 日 地
                else if select_endday == nil && select_statday == nil && select_area_str != nil{
                    
                    if (Results[i].showInfo?.count)! > 0 {
                        //有地點比較地點
                        for index in 0...(Results[i].showInfo?.count)!-1{
                            if   (select_area_str == "臺北市") || (select_area_str == "台北市")  {
                                
                                if (Results[i].showInfo![index].location?.hasPrefix("臺北市"))! || (Results[i].showInfo![index].location?.hasPrefix("台北市"))! {
                                    switch select_saleornot_str{
                                    case "收費"?:
//                                        if Results[i].showInfo![0].onSales == "Y"{
//                                            self.data1.append(Results[i])
//                                        }
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "Y"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "免費"?:
//                                        if Results[i].showInfo![0].onSales == "N"{
//                                            self.data1.append(Results[i])
//                                        }
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "N"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "兩者皆有"?:
                                        if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                            if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                            else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                        else{
                                            self.data1.append(Results[i])
                                        }
                                    default:
                                        print("error")
                                    }
                                }
                            }
                            else if   (select_area_str?.hasPrefix("臺中市"))! || (select_area_str?.hasPrefix("台中市"))!  {
                                
                                if (Results[i].showInfo![index].location?.hasPrefix("臺中市"))! || (Results[i].showInfo![index].location?.hasPrefix("台中市"))! {
                                    switch select_saleornot_str{
                                    case "收費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "Y"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "免費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "N"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "兩者皆有"?:
                                        if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                            if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                            else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                        else{
                                            self.data1.append(Results[i])
                                        }
                                    default:
                                        print("error")
                                    }
                                }
                            }
                            else if   (select_area_str?.hasPrefix("臺南市"))! || (select_area_str?.hasPrefix("台南市"))!  {
                                
                                if (Results[i].showInfo![index].location?.hasPrefix("臺南市"))! || (Results[i].showInfo![index].location?.hasPrefix("台南市"))! {
                                    switch select_saleornot_str{
                                    case "收費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "Y"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "免費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "N"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "兩者皆有"?:
                                        if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                            if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                            else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                        else{
                                            self.data1.append(Results[i])
                                        }
                                    default:
                                        print("error")
                                    }
                                }
                            }
                            else if   (select_area_str?.hasPrefix("臺東縣"))! || (select_area_str?.hasPrefix("台東縣"))!  {
                                
                                if (Results[i].showInfo![index].location?.hasPrefix("臺東縣"))! || (Results[i].showInfo![index].location?.hasPrefix("台東縣"))! {
                                    switch select_saleornot_str{
                                    case "收費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "Y"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "免費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "N"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "兩者皆有"?:
                                        if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                            if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                            else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                        else{
                                            self.data1.append(Results[i])
                                        }
                                    default:
                                        print("error")
                                    }
                                }
                            }
                            else{
                                
                                if (Results[i].showInfo![index].location?.hasPrefix(select_area_str!))! || (Results[i].showInfo![index].location?.hasPrefix(select_area_str!))!{
                                    switch select_saleornot_str{
                                    case "收費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "Y"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "免費"?:
                                        if (Results[i].showInfo?.count)! > 0 {
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else{
                                                    print("error")
                                                }
                                            }
                                            else if Results[i].showInfo![0].onSales == "N"{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                    case "兩者皆有"?:
                                        if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                            if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                            else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                self.data1.append(Results[i])
                                            }
                                        }
                                        else{
                                            self.data1.append(Results[i])
                                        }
                                    default:
                                        print("error")
                                    }
                                }
                            }
                        }
                    }
                    
                }
                //110 入 日 地
                else if select_endday != nil && select_statday != nil && select_area_str == nil{

                     if select_statday as! Date == select_statday?.earlierDate(result_startday as! Date) && select_endday as! Date == select_endday?.laterDate(result_endday as! Date ) && (Results[i].showInfo?.count)! >= 1{

                        switch select_saleornot_str{
                        case "收費"?:
                            if (Results[i].showInfo?.count)! > 0 {
                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else{
                                        print("error")
                                    }
                                }
                                else if Results[i].showInfo![0].onSales == "Y"{
                                    self.data1.append(Results[i])
                                }
                            }
                        case "免費"?:
                            if (Results[i].showInfo?.count)! > 0 {
                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                        self.data1.append(Results[i])
                                    }
                                    else{
                                        print("error")
                                    }
                                }
                                else if Results[i].showInfo![0].onSales == "N"{
                                    self.data1.append(Results[i])
                                }
                            }
                        case "兩者皆有"?:
                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                    self.data1.append(Results[i])
                                }
                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                    self.data1.append(Results[i])
                                }
                            }
                            else{
                                self.data1.append(Results[i])
                            }
                        default:
                             print("error")
                        }
                    }
                }
                //111
                else if select_endday != nil && select_statday != nil && select_area_str != nil{
                    if select_statday as! Date == (select_statday?.earlierDate(result_startday as! Date))! && select_endday as! Date == (select_endday?.laterDate(result_endday as! Date ))! && (Results[i].showInfo?.count)! >= 1{

                        
                            for index in 0...(Results[i].showInfo?.count)!-1{
                                if   (select_area_str == "臺北市") || (select_area_str == "台北市")  {

                                    if (Results[i].showInfo![index].location?.hasPrefix("臺北市"))! || (Results[i].showInfo![index].location?.hasPrefix("台北市"))! {
                                        switch select_saleornot_str{
                                        case "收費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "免費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "N"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "兩者皆有"?:
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                            else{
                                                self.data1.append(Results[i])
                                            }
                                        default:
                                             print("error")
                                        }
                                    }
                                }
                                else if   (select_area_str?.hasPrefix("臺中市"))! || (select_area_str?.hasPrefix("台中市"))!  {

                                    if (Results[i].showInfo![index].location?.hasPrefix("臺中市"))! || (Results[i].showInfo![index].location?.hasPrefix("台中市"))! {
                                        switch select_saleornot_str{
                                        case "收費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "免費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "N"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "兩者皆有"?:
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                            else{
                                                self.data1.append(Results[i])
                                            }
                                        default:
                                             print("error")
                                        }
                                    }
                                }
                                else if   (select_area_str?.hasPrefix("臺南市"))! || (select_area_str?.hasPrefix("台南市"))!  {

                                    if (Results[i].showInfo![index].location?.hasPrefix("臺南市"))! || (Results[i].showInfo![index].location?.hasPrefix("台南市"))! {
                                        switch select_saleornot_str{
                                        case "收費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "免費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "兩者皆有"?:
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                            else{
                                                self.data1.append(Results[i])
                                            }
                                        default:
                                             print("error")
                                        }
                                    }
                                }
                                else if   (select_area_str?.hasPrefix("臺東縣"))! || (select_area_str?.hasPrefix("台東縣"))!  {

                                    if (Results[i].showInfo![index].location?.hasPrefix("臺東縣"))! || (Results[i].showInfo![index].location?.hasPrefix("台東縣"))! {
                                        switch select_saleornot_str{
                                        case "收費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "免費"?:
                                            if (Results[i].showInfo?.count)! > 0 {
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else{
                                                        print("error")
                                                    }
                                                }
                                                else if Results[i].showInfo![0].onSales == "Y"{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                        case "兩者皆有"?:
                                            if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                                if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                                else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                    self.data1.append(Results[i])
                                                }
                                            }
                                            else{
                                                self.data1.append(Results[i])
                                            }
                                        default:
                                            print("error")
                                        }
                                    }
                                }
                                else{
                                 
                                        if (Results[i].showInfo![index].location?.hasPrefix(select_area_str!))! || (Results[i].showInfo![index].location?.hasPrefix(select_area_str!))! {
                                            switch select_saleornot_str{
                                            case "收費"?:
                                                if (Results[i].showInfo?.count)! > 0 {
                                                    if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "Y"{
                                                        if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                            self.data1.append(Results[i])
                                                        }
                                                        else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                            self.data1.append(Results[i])
                                                        }
                                                        else{
                                                            print("error")
                                                        }
                                                    }
                                                    else if Results[i].showInfo![0].onSales == "Y"{
                                                        self.data1.append(Results[i])
                                                    }
                                                }
                                            case "免費"?:
                                                if (Results[i].showInfo?.count)! > 0 {
                                                    if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil && Results[i].showInfo![0].onSales == "N"{
                                                        if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                            self.data1.append(Results[i])
                                                        }
                                                        else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                            self.data1.append(Results[i])
                                                        }
                                                        else{
                                                            print("error")
                                                        }
                                                    }
                                                    else if Results[i].showInfo![0].onSales == "Y"{
                                                        self.data1.append(Results[i])
                                                    }
                                                }
                                            case "兩者皆有"?:
                                                if input_textfield_str != "輸入關鍵字查詢" && input_textfield_str != "" && input_textfield_str != nil{
                                                    if (Results[i].title?.hasPrefix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                    else if (Results[i].title?.hasSuffix(input_textfield_str))!{
                                                        self.data1.append(Results[i])
                                                    }
                                                }
                                                else{
                                                    self.data1.append(Results[i])
                                                }
                                            default:
                                                print("error")
                                            }
                                        }
                                }
                        }
                    }
                }

            }
            self.data1 =  self.data1.sorted(by: {  $0.startDate! <  $1.startDate! })
            self.check_alert = true

        }
        else {
            print("json decode error")
        }
        OperationQueue.main.addOperation {
           
            self.tableview.reloadData()
            if self.check_viewdidappear  && self.check_alert == true {
                self.dismiss(animated: true, completion: nil)
            }
            

        }
    
    }
    
}
extension String
{
    func toDateTime() -> NSDate
    {
        //Create Date Formatter
        var dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.date(from: self)! as NSDate
        
        //Return Parsed Date
        return dateFromString
    }
}
