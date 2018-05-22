//
//  custom_search_schedule_map_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/4/12.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class custom_search_schedule_map_ViewController: UIViewController {

    var myLocationManager :CLLocationManager!
    var Latitude:Double?   //經度
    var longitude:Double?  //緯度
    let latDelta = 0.005
    let longDelta = 0.005
    var exibit_location_name:String?
    var exhibibt_location:String?
    var map_image:UIImage?
    
    @IBOutlet weak var mymap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mymap.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "mymap")
        if Latitude != nil && longitude != nil && Latitude != 0 && longitude != 0{   //有經緯度的狀況
            
            mymap.mapType = .standard
            mymap.showsCompass = true
            mymap.showsScale = true
            let currentLocationSpan:MKCoordinateSpan =
                MKCoordinateSpanMake(self.latDelta, self.longDelta)
            
            let center:CLLocation = CLLocation(latitude: Latitude!, longitude: longitude!)
            let currentRegion:MKCoordinateRegion =
                MKCoordinateRegion(
                    center: center.coordinate,
                    span: currentLocationSpan)
            mymap.setRegion(currentRegion, animated: true)
            
            var point_obj = MKPointAnnotation()
            point_obj.coordinate = CLLocation(latitude: Latitude!, longitude: longitude!).coordinate
            
            point_obj.title = "\(self.exibit_location_name!)"
            point_obj.subtitle = self.exhibibt_location
            
            mymap.addAnnotation(point_obj)
            mymap.selectAnnotation(point_obj, animated: true)
        }
        else{
            if exhibibt_location != nil{    //沒經緯度,兩種狀況處理: 1.有地址轉經緯度成功 ２.有地址轉經緯度失敗
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(exhibibt_location!, completionHandler: {
                    (placemarks:[CLPlacemark]?, error:Error?) -> Void in
                    
                    if let p = placemarks?[0]{   //1.有地址轉經緯度成功
                        print("地址轉換經緯度成功")
                        self.mymap.mapType = .standard
                        self.mymap.showsCompass = true
                        self.mymap.showsScale = true
                        
                        let currentLocationSpan:MKCoordinateSpan =
                            MKCoordinateSpanMake(self.latDelta, self.longDelta)
                        let center:CLLocation = CLLocation(latitude: p.location!.coordinate.latitude, longitude: p.location!.coordinate.longitude)
                        let currentRegion:MKCoordinateRegion =
                            MKCoordinateRegion(
                                center: center.coordinate,
                                span: currentLocationSpan)
                        self.mymap.setRegion(currentRegion, animated: true)
                        
                        var point_obj = MKPointAnnotation()
                        point_obj.coordinate = CLLocation(latitude: p.location!.coordinate.latitude, longitude: p.location!.coordinate.longitude).coordinate
                        
                        point_obj.title = "\(self.exibit_location_name!)"
                        point_obj.subtitle = self.exhibibt_location
                        self.mymap.addAnnotation(point_obj)
                        self.mymap.selectAnnotation(point_obj, animated: true)
                        
                    } else {     //２.有地址轉經緯度失敗
                        var alertcontroller_map = UIAlertController(title: "提示資訊", message: "無經緯度相關資訊", preferredStyle: .alert)
                        var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                            (UIAlertAction) -> Void in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alertcontroller_map.addAction(alert_action)
                        self.present(alertcontroller_map, animated: true, completion: nil)                }
                })
            }
            else{       //沒地址又沒經緯度
                var alertcontroller_map = UIAlertController(title: "提示資訊", message: "無經緯度相關資訊", preferredStyle: .alert)
                var alert_action = UIAlertAction(title: "ok", style: .default, handler:{
                    (UIAlertAction) -> Void in
                    self.navigationController?.popViewController(animated: true)
                })
                alertcontroller_map.addAction(alert_action)
                self.present(alertcontroller_map, animated: true, completion: nil)
            }
        }        // Do any additional setup after loading the view.
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
extension custom_search_schedule_map_ViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {      //判斷annotation是否為使用者現在所在位置,如果是回傳nil
            return nil
        }
        
        // 重複使用標註視圖
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "mymap") as? MKPinAnnotationView
        
        //如果沒有可用的標註視圖,創一個新的
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mymap")
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = map_image
        annotationView?.leftCalloutAccessoryView = leftIconView
        //        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }
}

