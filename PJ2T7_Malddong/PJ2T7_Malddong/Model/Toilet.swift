//
//  ToiletListModel.swift
//  PJ2T7_Malddong
//
//  Created by 정다산 on 12/5/23.
//

import Foundation


struct Toilet:Hashable,Identifiable{
    var id : UUID = UUID()
    var toiletImage: String
    var toiletName: String
    var toiletAddress: String
    var toiletDistance: String
    var like: Bool
    
    var laCrdnt:String
    var loCrdnt:String
    var rnAdres:String
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
}
