//
//  sale_web_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/5.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import WebKit
class sale_web_ViewController: UIViewController{

    var sale_web_str:String?
    
    
    @IBOutlet weak var sale_webkit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sale_webkit.scrollView.bounces = false
        
        if sale_web_str != "" && sale_web_str != nil && sale_web_str != "無相關資訊"{
            print(sale_web_str)
            var url_path  = URL(string: sale_web_str!)
            var request = URLRequest(url:url_path!)
            sale_webkit.load(request)
        }
        else {
            var alert_controller = UIAlertController(title: "提示資訊", message: "無網站資料", preferredStyle: UIAlertControllerStyle.alert)
            
            var ok_but = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
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

