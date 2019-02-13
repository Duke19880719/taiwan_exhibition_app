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
  let subUnit : [String]?
  let supportUnit : [String]?
  let otherUnit : [String]?
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

struct map_search_clture_facility_datastruct:Codable {
//    "name": "國立臺灣藝術大學藝文中心表演廳",
//    "representImage": "",
//    "intro": "演藝廳為校內唯一大型表演空間，民國72年竣工，使用迄今已達28年。演藝廳主舞臺寬約16米、深約12米、鏡框高約9米，舞臺配備懸吊系統，油壓式升降樂池，專業燈光及音響設備，組合式合唱臺階，活動音響反射板及山葉平臺式鋼琴，為一多功能設計之演出場所，觀眾席1117個座位。",
//    "address": "新北市板橋區大觀路一段69號",
//    "longitude": "121.44889",
//    "latitude": "25.006196",
//    "openTime": "08：00-22:00",
//    "closeDay": "無限定",
//    "ticketPrice": "-",
//    "contact": "羅煥隆",
//    "phone": "02-22722181#1753",
//    "email": "t0039@ntua.edu.tw",
//    "website": "http://portal2.ntua.edu.tw/",
//    "arriveWay": "",
//    "headCityName": "藝文中心",
//    "name_eng": "",
//    "intro_eng": ""
//    "openTime_eng": "",
//    "closeDay_eng": "",
//    "contact_eng": "",
//    "headCityName_eng": "",
//    "mainTypeName": "展演空間",
//    "cityName": "新北市  板橋區(板橋市)",
//    "groupTypeName": "展演設施",
//    "mainTypePk": "118",
//    "version": "1.0",
//    "hitRate": 622

    let name : String?
//    let representImage : String?
    let intro : String?
    let address : String?
    let longitude:  String?
    let latitude : String?
//    let website : String?
//    let srcWebsite : String?
    let mainTypeName : String?
//    let cityName : String?
    let groupTypeName : String?
//    let mainTypePk:String?
//    let version:String?
//    let hitRate:Int?
    let openTime:String?
}

