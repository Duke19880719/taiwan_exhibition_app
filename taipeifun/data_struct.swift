//
//  File.swift
//  taipeifun
//
//  Created by 江培瑋 on 2018/1/29.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import Foundation

struct display:Codable{
    
    let title : String?
    let showInfo : [ShowInfo]?
    let showUnit : String?
    let discountInfo : String?
    let descriptionFilterHtml : String?
    let imageUrl : String?
    let masterUnit : [String]?
 // let subUnit : [String]?
 // let supportUnit : [String]?
//  let otherUnit : [String]?
    let webSales : String?
    let sourceWebPromote : String?
  //  let comment : String?
    
    let sourceWebName : String?
    let startDate : String?
    let endDate : String?
   // let status : String?
    let total : String?
    let hitRate : Int?
    
    struct ShowInfo : Codable {
        let time : String?
        let location : String?
        let locationName : String?
        let onSales : String?
        let price : String?
        let latitude : String?
        let longitude : String?
        let endTime : String?
        //        init(from decoder: Decoder) throws {
        //            let values = try decoder.container(keyedBy: CodingKeys.self)
        //            time = try values.decodeIfPresent(String.self, forKey: .time)
        //            location = try values.decodeIfPresent(String.self, forKey: .location)
        //            locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        //            onSales = try values.decodeIfPresent(String.self, forKey: .onSales)
        //            price = try values.decodeIfPresent(String.self, forKey: .price)
        //            latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        //            longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        //            endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        //        }
    }
    
}

