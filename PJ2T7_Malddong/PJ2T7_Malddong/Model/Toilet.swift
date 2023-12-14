//
//  Toilet.swift
//  PJ2T7_Malddong


import Foundation
struct ToiletResponse: Decodable{
    var response: Response
}

struct Response : Decodable{
    var body: Body
    var header: Header
}

struct Header: Decodable{
    var resultCode: String
    var resultMsg: String
}

struct Body: Decodable{
    var pageNo: Int
    var items: Items
    var totalCount: Int
}

struct Items: Decodable{
    var item: [Toilet]
}


struct Toilet:Hashable,Decodable{
    var dataCd:String
   
    
    var laCrdnt:String
    var loCrdnt:String
//    var emdNm:String
    var lnmAdres:String
    var toiletNm:String
    var opnTimeInfo:String
    
    ///관리 기관명
    var mngrInsttNm:String
    
    var telno:String
    var maleClosetCnt: String  // 남성 대변기 수
    var maleUrinalCnt: String  // 남성 소변기 수
    var maleDspsnClosetCnt: String // 남성 장애인 대변기 수
    var maleDspsnUrinalCnt: String // 남성 장애인 소변기 수
    var maleChildClosetCnt: String // 남성 어린이 대변기 수
    var maleChildUrinalCnt: String // 남성 어린이 소변기 수

    var femaleClosetCnt: String // 여성 대변기 수
    var femaleChildClosetCnt: String // 여성 장애인 대변기 수
    var femaleDspsnClosetCnt: String // 여성 어린이 대변기 수
    
    var photo:[String]?
}
