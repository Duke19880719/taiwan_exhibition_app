//
//  sourceweb_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/2.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import WebKit
class sourceweb_ViewController: UIViewController {

    var sourceweb_url:String?
   
    @IBOutlet weak var webkit_obj: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sourceweb_url)
        webkit_obj.scrollView.bounces = false
        if sourceweb_url != "" && sourceweb_url != nil{
            var url_path  = URL(string: sourceweb_url!)
            var request = URLRequest(url:url_path!)
            webkit_obj.load(request)
        }
        else{
            var alert_controller = UIAlertController(title: "提示資訊", message: "無網站資料", preferredStyle: UIAlertControllerStyle.alert)
         
            var ok_but = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler:{
                (action: UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
            } )
            alert_controller.addAction(ok_but)
            present(alert_controller, animated: true, completion:nil)
        }
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
