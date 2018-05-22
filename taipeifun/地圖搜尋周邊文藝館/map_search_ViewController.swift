//
//  map_search_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/27.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class map_search_ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    var load_url:String?
    var data1:[map_search_clture_facility_datastruct]?
    @IBOutlet weak var search_map: MKMapView!
    var myLocationManager = CLLocationManager()
    var latitude:String? //經度
    var longitude:String?  //緯度
    let latDelta = 0.05
    let longDelta = 0.05
    var latitude_nsstr:NSString?
    var longitude_nsstr:NSString?
    var point_obj = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search_map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotationView")
        //  配置 locationManager
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest   //設定為最佳精度
       
        //  配置 mapView
        search_map.delegate = self
        search_map.showsUserLocation = true  //顯示user位置
        search_map.userTrackingMode = .follow  //隨著user移動
        

    }
  //測試座標 25.042297,121.53272
    func check_internet() -> Bool {
        var reachability = Reachability(hostName: "www.apple.com")
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            
            return false  //無網路
        }
        else{
            return true  //有網路
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //ps. 有發現沒有呼叫locationManager func的情形
            super.viewDidAppear(animated)
        if check_internet() == true{
            if CLLocationManager.authorizationStatus()
                == .notDetermined {
                // 取得定位服務授權
                myLocationManager.requestWhenInUseAuthorization()
                // 開始定位自身位置
                myLocationManager.startUpdatingLocation()
                
            }
                //  用戶不同意
            else if CLLocationManager.authorizationStatus() == .denied {
                // 提示可至[設定]中開啟權限
                let alertController = UIAlertController(
                    title: "定位權限已關閉",
                    message:
                    "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "確認", style: .default, handler:nil)
                alertController.addAction(okAction)
                self.present(
                    alertController,
                    animated: true, completion: nil)
            }
                // 使用者已經同意定位自身位置權限
            else if CLLocationManager.authorizationStatus()
                == .authorizedWhenInUse {
                // 開始定位自身位置
                myLocationManager.startUpdatingLocation()
                
            }
            search_map.showsUserLocation = true
            search_map.userTrackingMode = .follow
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
    override func viewWillDisappear(_ animated: Bool) {
       
        search_map.showsUserLocation = false
        search_map.userTrackingMode = .none
        var allAnnotations = self.search_map.annotations
       
        self.search_map.removeAnnotations(allAnnotations)
        // 停止定位自身位置
        myLocationManager.stopUpdatingLocation()

        super.viewDidDisappear(animated)
        
      
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //開啟update位置後 startUpdatingLocation()，觸發func locationManager, [CLLocation]會取得所有定位點，[0]為最新點
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation :CLLocation =
            locations[0] as CLLocation
        latitude = String(currentLocation.coordinate.latitude)
        longitude = String(currentLocation.coordinate.longitude)
      
        let currentLocationSpan:MKCoordinateSpan =
            MKCoordinateSpanMake(self.latDelta, self.longDelta)
        let center:CLLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let currentRegion:MKCoordinateRegion =
            MKCoordinateRegion(
                center: center.coordinate,
                span: currentLocationSpan)
        self.search_map.setRegion(currentRegion, animated: true)
    
        load_jason(latitude_string: latitude!, longitude_string: longitude!)
    }
    
    func load_jason(latitude_string:String,longitude_string:String) -> Void {
        load_url = "https://cloud.culture.tw/frontsite/opendata/emapOpenDataJsonAction.do?method=exportEmapJsonNearBy&lat=\(latitude_string)&lon=\(longitude_string)&range=2"
        var url1 = URL(string: load_url!)

        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: self ,
                                 delegateQueue: OperationQueue.main)
        
        let request = URLRequest(url: url1!)
        
        let dataTask =  session.downloadTask(with:request)
        
        dataTask.resume()
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

extension map_search_ViewController:URLSessionDownloadDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
            annotationView?.canShowCallout = true
            let subtitleView = UILabel()
            subtitleView.font = subtitleView.font?.withSize(15)
            subtitleView.numberOfLines = 9
            subtitleView.text = annotation.subtitle!
            annotationView!.detailCalloutAccessoryView = subtitleView
         
            return annotationView
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var temp_data:Data?
        let decoder = JSONDecoder()
        temp_data = try! Data(contentsOf: location)
        decoder.dateDecodingStrategy = .iso8601
        
        if let data1 = temp_data, let Results = try?
            decoder.decode([map_search_clture_facility_datastruct].self, from: data1)
        {
            print("succes\n")
            self.data1 = Results
        }
        else {
            print("json decode error")
        }
        
        OperationQueue.main.addOperation {
            if (self.data1?.count)! >= 1
            {
            for i in 0...(self.data1?.count)!-1{
               
                //有座標的情況
                if self.data1?[i].latitude != nil && self.data1?[i].longitude != nil && self.data1?[i].mainTypeName != "社區" && self.data1?[i].mainTypeName != "公共藝術" && self.data1?[i].groupTypeName != "文化資產"{
                    self.point_obj = MKPointAnnotation()
                    self.latitude_nsstr = self.data1?[i].latitude as NSString?
                    self.longitude_nsstr = self.data1?[i].longitude as NSString?
                    self.point_obj.coordinate = CLLocation(latitude: (self.latitude_nsstr?.doubleValue)!, longitude: (self.longitude_nsstr?.doubleValue)!).coordinate
                   
                    self.point_obj.title = self.data1?[i].name
                    if self.data1?[i].openTime != nil{
                        self.point_obj.subtitle = "分類：\((self.data1?[i].mainTypeName)!)\n地址：\((self.data1?[i].address)!)\n時間:\((self.data1?[i].openTime)!)"
                    }
                    else{
                        self.point_obj.subtitle = "分類：\((self.data1?[i].mainTypeName)!)\n地址：\((self.data1?[i].address)!)"
                    }
                    
                    self.search_map.addAnnotation(self.point_obj)
                    self.search_map.selectAnnotation(self.point_obj, animated: true)
                }
                //沒座標的情況,地址轉座標
                else{

                    if self.data1?[i].latitude != nil && self.data1?[i].longitude != nil && self.data1?[i].mainTypeName != "社區" && self.data1?[i].mainTypeName != "公共藝術" && self.data1?[i].groupTypeName != "文化資產"{    //沒經緯度,兩種狀況處理: 1.有地址轉經緯度成功
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString((self.data1?[i].address)!, completionHandler: {
                            (placemarks:[CLPlacemark]?, error:Error?) -> Void in

                            if let p = placemarks?[0]{   //1.有地址轉經緯度成功
                                print("地址轉換經緯度成功")
                                self.point_obj = MKPointAnnotation()
                                self.point_obj.coordinate = CLLocation(latitude: p.location!.coordinate.latitude, longitude: p.location!.coordinate.longitude).coordinate

                                self.point_obj.title = self.data1?[i].name

                                if self.data1?[i].openTime != nil{
                                    self.point_obj.subtitle = "分類：\((self.data1?[i].mainTypeName)!)\n地址：\((self.data1?[i].address)!)\n時間:\((self.data1?[i].openTime)!)"
                                }
                                else{
                                    self.point_obj.subtitle = "分類：\((self.data1?[i].mainTypeName)!)\n地址：\((self.data1?[i].address)!)"
                                }
                                self.search_map.addAnnotation(self.point_obj)
                                self.search_map.selectAnnotation(self.point_obj, animated: true)

                            }
                        })
                    }

                }        // Do any additional setup after loading the view.
            }}
                
        }
            
    }
}

