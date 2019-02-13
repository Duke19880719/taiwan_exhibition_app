//
//  favorite_ViewController.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/3/10.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import CoreData

class favorite_ViewController: UIViewController {
    var exibition:[User_favorit_exibition]?
    var fetchresultcontroller:NSFetchedResultsController<User_favorit_exibition>?
    var saleornot:String?
    
    @IBOutlet weak var tableview_outlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var fetchrequest:NSFetchRequest<User_favorit_exibition> = User_favorit_exibition.fetchRequest()
        var sort_method = NSSortDescriptor(key: "time", ascending: true)
        fetchrequest.sortDescriptors = [sort_method]
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appdelegate.persistentContainer.viewContext
            fetchresultcontroller = NSFetchedResultsController(fetchRequest: fetchrequest,managedObjectContext: context, sectionNameKeyPath: nil,cacheName: nil)
            fetchresultcontroller?.delegate = self
            do{
                try fetchresultcontroller?.performFetch()
                if let fectch_result = fetchresultcontroller?.fetchedObjects{
                    exibition = fectch_result
                }
            }catch{
                print("error")
            }
        }
//        tableview_outlet.layer.masksToBounds = true
//        tableview_outlet.layer.borderColor = UIColor.orange.cgColor
//        tableview_outlet.layer.borderWidth = 4
//        tableview_outlet.layer.cornerRadius = 10


    }
    override func viewWillAppear(_ animated: Bool) {
        tableview_outlet.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    var title_temp:String?
//    var img_exhib:UIImage?
//    var unit:String?
//    var time_str:String?
//    var source_web_str:String?
//    var websale_str:String?
//    var discount_str:String?
//    var activity_str:String?
//    var description_str:String?
//    var saleornot_str:String?
//    var promote_source_url:String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favorite_passto_detail"{
            var destaination_1 = segue.destination as! UINavigationController
            var destaination_2 = destaination_1.topViewController as! favorite_detail_ViewController
            destaination_2.exibition = [exibition![(tableview_outlet.indexPathForSelectedRow?.row)!]]
            
 
            destaination_2.title_temp = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].title_temp
            destaination_2.img_exhib = UIImage(data:exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].img_exhib!)
            destaination_2.unit = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].unit
            destaination_2.time_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].time_str
            destaination_2.source_web_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].source_web_str
            destaination_2.websale_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].websale_str
            destaination_2.discount_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].discount_str
            destaination_2.activity_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].activity_str
            destaination_2.description_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].description_str
            destaination_2.saleornot_str = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].saleornot_str
            destaination_2.promote_source_url = exibition![(tableview_outlet.indexPathForSelectedRow?.row)!].promote_source_url
        }
    }
}

extension favorite_ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if exibition != nil{
            return (exibition?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "favorite_TableViewCell",for: indexPath) as! favorite_TableViewCell
//        cell.echibit_img.image = UIImage(data: exibition![indexPath.row].img_exhib!)
//        
//        cell.exhibit_name.text = exibition![indexPath.row].title_temp!
//        
//        sale_or_not(exibition![indexPath.row].saleornot_str!)
//        
//        cell.location_sale.text = "\(exibition![indexPath.row].location!)\n\(saleornot!)"
//        
//        cell.time.text = "\(exibition![indexPath.row].time_str!)"
//        
//        cell.index_display.text = String(indexPath.row + 1)
        
       return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var cell =  cell as! favorite_TableViewCell
       
        //設置圖片圓形
        cell.echibit_img.clipsToBounds = true
        
        cell.echibit_img.layer.cornerRadius = 10
        
        //cell animate
        let cell_transform = CATransform3DTranslate(CATransform3DIdentity, 1000, 0, 1000)
        
        cell.layer.transform = cell_transform
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
        }
        //cell ui design
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.alpha = 0.65
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        
        cell.echibit_img.image = UIImage(data: exibition![indexPath.row].img_exhib!)
        
        cell.exhibit_name.text = exibition![indexPath.row].title_temp!
        
        sale_or_not(exibition![indexPath.row].saleornot_str!)
        if exibition![indexPath.row].location != nil{
            cell.location_sale.text = "\(exibition![indexPath.row].location!)\n\(saleornot!)"
        }
        else{
            cell.location_sale.text = "無地點相關資訊\n\(saleornot!)"
        }


        cell.time.text = "\(exibition![indexPath.row].time_str!)"
        
        cell.index_display.text = String(indexPath.row + 1)
        
    }
    func sale_or_not(_ temp_str:String)  {
        
        if temp_str == "Y"{
            saleornot = "售票"
        }
            
        else if temp_str == "N"{
            saleornot = "免費"
        }
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteaction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "刪除", handler:
        {
            (action,indexPath) -> Void in
            
            if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
                
                var  context = appdelegate.persistentContainer.viewContext
                var  delete_obj = self.fetchresultcontroller?.object(at: indexPath)
                context.delete(delete_obj!)
                appdelegate.saveContext()
            }
        })

        return [deleteaction]
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.exibition?.remove(at: indexPath.row)
        }
        self.tableview_outlet.deleteRows(at: [indexPath] , with: .fade)
    }
}

extension favorite_ViewController:NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview_outlet.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableview_outlet.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableview_outlet.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableview_outlet.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            self.tableview_outlet.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            exibition = fetchedObjects as? [User_favorit_exibition]
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableview_outlet.endUpdates()
    }
}


