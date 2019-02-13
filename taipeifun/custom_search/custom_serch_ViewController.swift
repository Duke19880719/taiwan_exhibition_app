//
//  custom_serch_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/9.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class custom_serch_ViewController: UIViewController {

    @IBOutlet weak var pickerview_outlet: UIPickerView!
    @IBOutlet weak var activity_tap: UIButton!
    @IBOutlet weak var inner_view: UIView!
    @IBOutlet var scroll_view: UIView!
    @IBOutlet weak var area_outlet: UIButton!
    @IBOutlet weak var datepick_outlet: UIDatePicker!
    @IBOutlet weak var stardate_choise: UIButton!
    @IBOutlet weak var enddate: UIButton!
    @IBOutlet weak var search_textfield_outlet: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var finish_search_but: UIButton!
    
    var url:String?
    var date_choise:Bool?
    var activity:Bool?
    var area_choise:Bool?
    var isstardate:Bool?
    var activity_array:[String] = ["音樂","戲劇","舞蹈","親子","獨立音樂","展覽","講座",
        "電影","綜藝","競賽","徵選","其他","未知分類","演唱會","研習課程"]
    var city:[String] = [
        "台東縣","台南市","台中市","台北市","新竹市","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","宜蘭縣","花蓮縣"
        ,"澎湖縣","基隆市","新竹市","嘉義市","新北市","桃園市","高雄市","新竹縣","澎湖縣","金門縣","連江縣","花蓮市"]
    var select_activity_str:String?
    var select_saleornot_str:String?
    var select_startday_str:String?
    var select_endday_str:String?
    var select_area_str:String?
    var input_textfield_str:String?
    
 
    
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search_textfield_outlet.delegate = self
        inner_view.layer.cornerRadius = 10
        datepick_outlet.isHidden = true
        pickerview_outlet.isHidden = true
        activity_tap.layer.cornerRadius = 10
        area_outlet.layer.cornerRadius = 10
        stardate_choise.layer.cornerRadius = 10
        enddate.layer.cornerRadius = 10
        finish_search_but.layer.cornerRadius = 10
        
        search_textfield_outlet.borderStyle = .roundedRect
        search_textfield_outlet.layer.borderWidth = 2
        search_textfield_outlet.layer.borderColor = UIColor.black.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(scroll_view)
        scroll_view.translatesAutoresizingMaskIntoConstraints = false
        scroll_view.heightAnchor.constraint(equalToConstant: 165).isActive = true
        scroll_view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        scroll_view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
        let move = scroll_view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 165)
        move.identifier = "move_id"
        move.isActive = true
        
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func act_tap_action(_ sender: Any) {
        pickerview_outlet.isHidden = false
        activity = true
        area_choise = false
        date_choise = false
        activity_tap.layer.borderColor = UIColor.clear.cgColor
        activity_tap.layer.borderWidth = 4
        for c in view.constraints{
            if c.identifier == "move_id"{
                c.constant = -60
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func area_tap_action(_ sender: Any) {
        pickerview_outlet.isHidden = false
        activity = false
        area_choise = true
        date_choise = false
       
        for c in view.constraints{
            if c.identifier == "move_id"{
                c.constant = -60
                break
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func stardate_choise_action(_ sender: UIButton) {
        datepick_outlet.isHidden = false
        for c in view.constraints{
            if c.identifier == "move_id"{
                c.constant = -60
                break
            }
        }
        if sender == stardate_choise{
            isstardate = true

        }
        else if sender == enddate{
            isstardate = false

        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func select_finish_action(_ sender: Any) {

        formatter.dateFormat = "yyyy/MM/dd"
        
        for c in view.constraints{
            if c.identifier == "move_id"{
                c.constant = 165
                break
            }
        }
        if activity == true && area_choise == false{
           activity_tap.setTitle(activity_array[pickerview_outlet.selectedRow(inComponent: 0)], for: .normal)
            select_activity_str = activity_array[pickerview_outlet.selectedRow(inComponent: 0)]
            check_activity_touch(act_str: activity_array[pickerview_outlet.selectedRow(inComponent: 0)])
        }
        else if activity == false && area_choise == true{
            area_outlet.setTitle(city[pickerview_outlet.selectedRow(inComponent: 0)], for: .normal)
            select_area_str = city[pickerview_outlet.selectedRow(inComponent: 0)]
        }
        else if isstardate == true{
            stardate_choise.setTitle(formatter.string(from: datepick_outlet.date), for: .normal)
            select_startday_str = formatter.string(from: datepick_outlet.date)
        }
        else if isstardate == false{
            enddate.setTitle(formatter.string(from:datepick_outlet.date), for: .normal)
            select_endday_str = formatter.string(from:datepick_outlet.date)
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        datepick_outlet.isHidden = true
        pickerview_outlet.isHidden = true
        activity = false
        area_choise = false
    }
    func check_activity_touch(act_str:String) -> Void {
//        ["音樂","戲劇","舞蹈","親子","獨立音樂","展覽","講座",
//         "電影","綜藝","競賽","徵選","其他","未知分類","演唱會","研習課程"]
//        1=音樂  2=戲劇  3=舞蹈  4=親子  5=獨立音樂  6=展覽   7=講座
//        8=電影  11=綜藝  13=競賽  14=徵選  15=其他  16=未知分類  17=演唱會
        switch act_str {
        case "音樂":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=1"
        case "戲劇":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=2"
        case "舞蹈":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=3"
        case "親子":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=4"
        case "獨立音樂":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=5"
        case "展覽":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=6"
        case "講座":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=7"
        case "電影":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=8"
        case "綜藝":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=11"
        case "競賽":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=13"
        case "徵選":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=14"
        case "其他":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=15"
        case "未知分類":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=16"
        case "演唱會":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=17"
        case "研習課程":
            url = "https://cloud.culture.tw/frontsite/opendata/activityOpenDataJsonAction.do?method=doFindActivitiesByCategory&category=19"
        default:
            print("no value")
        }
    }
    
    @IBAction func segment_value_change(_ sender: UISegmentedControl) {
        select_saleornot_str = sender.titleForSegment(at: sender.selectedSegmentIndex)

    }
    
    @IBAction func finish_goto_next_page_act(_ sender: Any) {
        select_saleornot_str = segment.titleForSegment(at: segment.selectedSegmentIndex)
        
        if search_textfield_outlet.text != "輸入關鍵字查詢,結果不包括其他搜尋條件" {
            input_textfield_str = search_textfield_outlet.text
        }
        input_textfield_str = search_textfield_outlet.text
//--------------------------日期防呆－－－－－－－－－－－－－－－－－－－－－－－－－－
        
        var startday = select_startday_str?.toDateTime()
        var endday = select_endday_str?.toDateTime()
        if endday != nil && startday != nil,endday as? Date == endday?.earlierDate((startday as? Date)!){
            var alertcontroller_map = UIAlertController(title: "提示資訊", message: "截止日期小於開始日期", preferredStyle: .alert)
            var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                (UIAlertAction) -> Void in
                self.enddate.layer.borderColor = UIColor.red.cgColor
                self.enddate.layer.borderWidth = 4
            })
            alertcontroller_map.addAction(alert_action)
            self.present(alertcontroller_map, animated: true, completion: nil)
        }
        else{
            self.enddate.layer.borderColor = UIColor.clear.cgColor
            self.enddate.layer.borderWidth = 4
        }
//-----------------------------------------------------------------------
//－－－－－－－－－－－－－－－－－－－－活動選擇防呆－－－－－－－－－－－－－－
        if select_activity_str == nil{
            var alertcontroller_map = UIAlertController(title: "提示資訊", message: "沒有選擇活動種類", preferredStyle: .alert)
            var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                (UIAlertAction) -> Void in
                self.activity_tap.layer.borderColor = UIColor.red.cgColor
                self.activity_tap.layer.borderWidth = 4
            })
            alertcontroller_map.addAction(alert_action)
            self.present(alertcontroller_map, animated: true, completion: nil)
        }
//------------------------------------------------------------------------
        if check_internet() == true{
             performSegue(withIdentifier: "pass_to_result", sender: nil)
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
    func check_internet() -> Bool {
        var reachability = Reachability(hostName: "www.apple.com")
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            
            return false  //無網路
        }
        else{
            return true  //有網路
        }
    }
  

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pass_to_result"{
    
            
            var point_to_nav = segue.destination as! UINavigationController
            var nav_point_to = point_to_nav.topViewController as! custom_search_exibit_info_ViewController
            
            nav_point_to.select_activity_str = select_activity_str
            nav_point_to.select_saleornot_str = select_saleornot_str
            nav_point_to.select_startday_str = select_startday_str
            nav_point_to.select_endday_str = select_endday_str
            nav_point_to.select_area_str = select_area_str
            nav_point_to.url = url
            nav_point_to.input_textfield_str = search_textfield_outlet.text!
        }
        
        
    }
 
}
extension custom_serch_ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activity == true && area_choise == false{
            return activity_array.count
        }
        else if activity == false && area_choise == true{
            return city.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activity == true && area_choise == false{
            return activity_array[row]
        }
        else if activity == false && area_choise == true{
            return city[row]
        }
        return ""
    }
}
extension custom_serch_ViewController:UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        search_textfield_outlet.text = ""
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.text == ""{
            textField.text = "輸入關鍵字查詢"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
