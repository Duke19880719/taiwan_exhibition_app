//
//  ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/1/2.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var data_count: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var display_info: UILabel!
    var alert_str:String?
    var temp_str:String?
    var temp_i:Int = 0
    var image_array = [UIImage(named:"exhibit")!,UIImage(named:"drama")!,UIImage(named:"music")!,UIImage(named:"dance")!,UIImage(named:"indentpend_music")!,UIImage(named:"movie")!,UIImage(named:"elseArt")!]
    var collection_str:[String] = ["展覽資訊","戲劇資訊","音樂資訊","舞蹈資訊","獨立音樂資訊","電影資訊","其他藝文資訊"]
   
    var data1:[display]?
    
    var exhibit_struct:[display]?,drama_struct:[display]?,music_struct:[display]?,dance_struct:[display]?,independ_music_struct:[display]?,movie_struct:[display]?,elseArt_struct:[display]?
    var urlstr1 = "https://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=6"
    var url1:URL?
    var currentSession:URLSession?
    var saleornot:String?
    var img:UIImage?
    var temp_price:String = ""
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableview.layer.masksToBounds = true
//        tableview.layer.borderColor = UIColor.orange.cgColor
//        tableview.layer.borderWidth = 4
//        
//        tableview.layer.cornerRadius = 10
        
//        tableview.layer.shadowColor = UIColor.black.cgColor
//        tableview.layer.shadowOffset = CGSize(width: 2, height: 2)
//        tableview.layer.shadowRadius = 3
//        tableview.layer.shadowOpacity = 0.5
        display_info.text = "請點選上方圖示顯示資訊"
      var header_view = UIView()
      header_view.frame = CGRect(x: 0, y: 0, width: self.tableview.bounds.width, height: 1) 
      self.tableview.tableHeaderView = header_view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {     //collectionview button dynamic coding
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.menu_but.setImage(image_array[indexPath.row], for: .normal)
        cell.set_value(who_touch:collection_str[indexPath.row])
        cell.changeword = self

        return cell
    }
}

extension ViewController:change{             //protocol change method coding
    func reduce(load_url:String)  {
        var alert_controller = UIAlertController(title: "\(alert_str!)資料下載中", message: "\n\n\n", preferredStyle: UIAlertControllerStyle.alert)
        var alert_activity = UIActivityIndicatorView(frame:alert_controller.view.bounds)
        alert_activity.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        alert_activity.color = UIColor.blue
        alert_activity.startAnimating()

        alert_controller.view.addSubview(alert_activity)

        self.present(alert_controller, animated: true, completion: nil)
        
        url1 = URL(string: load_url)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: self ,
                                 delegateQueue: OperationQueue.main)
        
        let request = URLRequest(url: url1!)
        
        let dataTask =  session.downloadTask(with:request)

        dataTask.resume()
        
    }
    func load_jsondata(url_path: String,change_word: String) {
  
        switch change_word {
        case "展覽資訊":
            if exhibit_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    exhibit_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
            }
            else
            {
                self.data1 = exhibit_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
          
        case "戲劇資訊":
            if drama_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    drama_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
            }
            else
            {
                self.data1 = drama_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
        case "音樂資訊":
            if music_struct == nil
            {
                
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    music_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
                
            }
            else
            {
                self.data1 = music_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
          
        case "舞蹈資訊":
            if dance_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    music_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
                
            }
            else
            {
                self.data1 = dance_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
        
        case "獨立音樂資訊":
            if independ_music_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    music_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
            }
            else
            {
                self.data1 = independ_music_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
        
        case "電影資訊":
            if movie_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    music_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
               
            }
            else
            {
                self.data1 = movie_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
       
        case "其他藝文資訊":
            if elseArt_struct == nil
            {
                if check_internet() == true{
                    alert_str = change_word
                    reduce(load_url: url_path)
                    music_struct = self.data1
                }
                else{
                    var alertcontroller_map = UIAlertController(title: "無網路", message: "請開啟您的行動網路 或 Wi-Fi", preferredStyle: .alert)
                    var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                        (UIAlertAction) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertcontroller_map.addAction(alert_action)
                    self.present(alertcontroller_map, animated: true, completion: nil)
                }
            }
            else
            {
                self.data1 = elseArt_struct
                OperationQueue.main.addOperation {
                    self.tableview.reloadData()
                    self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
                }
            }
        default:
            print("no value")
        }
    }
    
    func changelabel(change_word: String) {
        display_info.text = change_word
    }
    func check_internet() -> Bool {
        var reachability = Reachability(hostName: "www.apple.com")
        if reachability?.currentReachabilityStatus().rawValue == 0 {
        
            return false  //無網路
        }
        else{
            return true  //有網路
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
 
    func numberOfSections(in tableView: UITableView) -> Int {
       
        if data1 != nil{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if data1 != nil{
            return (data1?.count)!
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let table_cell = tableView.dequeueReusableCell(withIdentifier: "exhibit_TableViewCell", for: indexPath) as! exhibit_TableViewCell

        return table_cell
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var location_str:String = ""
        
        let table_cell = cell as! exhibit_TableViewCell
        
        
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
        
        
        //
        if data1![indexPath.row].imageUrl != "" && data1![indexPath.row].imageUrl != nil {
            let url = URL(string: data1![indexPath.row].imageUrl!)
            var data2 = try? Data(contentsOf: url!)
            if data2 != nil{
                var temp_img:UIImage = resizeImage(originalImg: UIImage(data: data2!)!)
                
                table_cell.echibit_img.image = temp_img
            }
            else{
                table_cell.echibit_img.image = #imageLiteral(resourceName: "no_image_url")
            }
        }
        else{
            table_cell.echibit_img.image = #imageLiteral(resourceName: "no_image_url")
        }
        table_cell.exhibit_name.text = data1![indexPath.row].title
        
        if data1![indexPath.row].showInfo!.count == 1{
            location_str = city_finf(location1: data1![indexPath.row].showInfo![0].location!)
        }
        else if  data1![indexPath.row].showInfo!.count>1{
            location_str = city_finf(location1: data1![indexPath.row].showInfo![0].location!) + ",其他地點"
        }
        
        table_cell.time.text = "\((data1![indexPath.row].startDate)!)-\((data1![indexPath.row].endDate)!) "
        
        if data1![indexPath.row].showInfo!.count > 0 ,data1![indexPath.row].showInfo![0].onSales != ""{
            sale_or_not(data1![indexPath.row].showInfo![0].onSales!)
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
        data_count.text = "\(data1!.count)筆"
        
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
     
        var pointto = segue.destination as! UINavigationController
        var tran_obj = pointto.topViewController as! display_info_ViewController
        

      tran_obj.promote_source_url = data1![(tableview.indexPathForSelectedRow?.row)!].sourceWebPromote
        
        
      tran_obj.detail_array = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo!
        
        
        if  data1![(tableview.indexPathForSelectedRow?.row)!].showInfo!.count > 0{
            print()
            var  ggy:Int = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo!.count
            
               temp_price =  data1![(tableview.indexPathForSelectedRow?.row)!].showInfo![0].price!
        }
        
       tran_obj.title_temp = "\(data1![(tableview.indexPathForSelectedRow?.row)!].title!)"

        if data1![(tableview.indexPathForSelectedRow?.row)!].imageUrl != "" {
            let url = URL(string: data1![(tableview.indexPathForSelectedRow?.row)!].imageUrl!)
            var data2 = try? Data(contentsOf: url!)
             tran_obj.img_exhib = UIImage(data: data2!)
        }
        else{
             tran_obj.img_exhib = #imageLiteral(resourceName: "no_image_url")
        }
        
        if data1![(tableview.indexPathForSelectedRow?.row)!].descriptionFilterHtml != ""{
              tran_obj.description_str = "簡介：\n\(data1![(tableview.indexPathForSelectedRow?.row)!].descriptionFilterHtml!)"
        }
        else{
            tran_obj.description_str = "無簡介相關資訊"
        }
        
        if data1![(tableview.indexPathForSelectedRow?.row)!].startDate != ""{
            tran_obj.time_str = "展出時間：\(String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].startDate!)) - \(String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].endDate!))"
        }
        else{
            tran_obj.time_str = "無時間相關資訊"
        }
        
        var seprator = NSCharacterSet(charactersIn: "[]\"()中華民國null")
        var recevie_masterunit:String =  String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].masterUnit!)
        var recevie_shownunit:String =  String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].showUnit!)
        var complete_showunit_str = recevie_shownunit.components(separatedBy: seprator as CharacterSet)
        
        var complete_masterunit_str = recevie_masterunit.components(separatedBy: seprator as CharacterSet)
        
        var temp_location:String?
        
        if data1![(tableview.indexPathForSelectedRow?.row)!].showInfo!.count > 0{
           if data1![(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location != "" || data1![(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location != nil{
                temp_location = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo![0].location!
            }
           else {
            temp_location = "無地點相關資訊"
            }
        }

        if data1![(tableview.indexPathForSelectedRow?.row)!].masterUnit?.count != 0 && complete_showunit_str[0] != ""{
            if data1![(tableview.indexPathForSelectedRow?.row)!].showInfo?.count == 1 {
                tran_obj.unit = "表演單位：\(complete_showunit_str[0])\t主辦單位：\(complete_masterunit_str[0])\n地點：\(temp_location!)"
            }
            if let temp_str1 = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo?.count,temp_str1 > 1{
                 tran_obj.unit = "表演單位：\(complete_showunit_str[0])\t主辦單位：\(complete_masterunit_str[0])\n地點：\(temp_location!),其他地點詳見場次資訊"
            }
        }
        else{
            
            if data1![(tableview.indexPathForSelectedRow?.row)!].showInfo?.count == 1 {
               tran_obj.unit = "表演單位：無相關資訊\t主辦單位：無相關資訊\n地點：\(temp_location!)"
            }
            if let temp_str1 = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo?.count,temp_str1 > 1{
                tran_obj.unit = "表演單位：無相關資訊\t主辦單位：無相關資訊\n地點：\(temp_location!),其他地點詳見場次資訊"
            }
            
        }
        
        tran_obj.source_web_str = "\(String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].sourceWebName!))"
        
        if data1![(tableview.indexPathForSelectedRow?.row)!].webSales != ""{
        tran_obj.websale_str = "\(String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].webSales!))"
        }
        else{
            tran_obj.websale_str = "無相關資訊"
        }
        
        var seprator0 = NSCharacterSet(charactersIn: "<>br/")
        var recevie_discount:String =  String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].discountInfo!)
        var complete_discount_str = recevie_discount.components(separatedBy: seprator0 as CharacterSet)
        
        var seprator1 = NSCharacterSet(charactersIn: "<>br/[]\"")
        var receive_price:String = temp_price
        var complete_price = receive_price.components(separatedBy: seprator1 as CharacterSet)
        
        if data1![(tableview.indexPathForSelectedRow?.row)!].discountInfo != ""{
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
        
        if let count_show = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo?.count ,count_show > 0{
            tran_obj.saleornot_str = data1![(tableview.indexPathForSelectedRow?.row)!].showInfo![0].onSales!
        }
        else{
            tran_obj.saleornot_str = "no value"
        }
        tran_obj.activity_str = "活動場次：\(String(describing: data1![(tableview.indexPathForSelectedRow?.row)!].showInfo!.count))場,點擊查看詳細資訊"
        
    }
        
    }
}

extension ViewController:URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var tem_data:Data?
        let decoder = JSONDecoder()
        tem_data = try! Data(contentsOf: location)
        decoder.dateDecodingStrategy = .iso8601
        
       self.dismiss(animated: true, completion: nil)
        
        if let data1 = tem_data, let Results = try?
            decoder.decode([display].self, from: data1)
        {
            print("succes")
            self.data1 = Results
        
            self.data1 =  self.data1?.sorted(by: {  $0.startDate! <  $1.startDate! })
        }
        else {
            print("json decode error")
        }
        OperationQueue.main.addOperation {
            self.tableview.reloadData()
            self.tableview.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
            
        }
    }

}

//圖片尺寸轉換規則
//a，圖片寬或者高均小於或等於1280時圖片尺寸保持不變，不改變圖片大小
//b,寬或者高大於1280，但是圖片寬度高度比小於或等於2，則將圖片寬或者高取值大的等比壓縮至1280
//c，寬或者高均大於1280，但是圖片寬高比大於2，則寬或者高取值小的等比壓縮至1280
//**d, **寬或者高，只有一個值大於1280 ，並且寬高比超過2，不改變圖片大小


public func resizeImage(originalImg:UIImage) -> UIImage{
    
    //prepare constants
    let width = originalImg.size.width
    let height = originalImg.size.height
    let scale = width/height
    
    var sizeChange = CGSize()
    
    if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
        return originalImg
    }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
        
        if scale <= 2 && scale >= 1 {
            let changedWidth:CGFloat = 1280/32
            let changedheight:CGFloat = changedWidth / scale
            sizeChange = CGSize(width: changedWidth, height: changedheight)
            
        }else if scale >= 0.5 && scale <= 1 {
            
            let changedheight:CGFloat = 1280/32
            let changedWidth:CGFloat = changedheight * scale
            sizeChange = CGSize(width: changedWidth, height: changedheight)
            
        }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
            
            if scale > 2 {//高的值比较小
                
                let changedheight:CGFloat = 1280/32
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale < 0.5{//宽的值比较小
                
                let changedWidth:CGFloat = 1280/32
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }
        }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
            return originalImg
        }
    }
    
    UIGraphicsBeginImageContext(sizeChange)
    
    //draw resized image on Context
    originalImg.draw(in: CGRect(x:0,y: 0,width:sizeChange.width,  height:sizeChange.height))
    
    //create UIImage
    let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return resizedImg!
    
}
