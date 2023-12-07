//  Parking.swift
//  PJ2T7_Malddong
//
//  Created by 김수비 on 12/7/23.
//

import Foundation

struct Results: Decodable {
    let currentCount: Int
    let data: [Parking]
}

struct Parking: Hashable, Decodable {
    var 경도: String
    var 공휴일운영시작시각: String
    var 공휴일운영종료시각:String
    var 관리기관명:String
    var 수정일자:String
    var 연락처:String
    
    var 요금정보:String
    var 운영요일: String
    var 위도: String
    var 주차구획수: String
    var 주차장관리번호: String
    var 주차장구분: String
    var 주차장도로명주소: String
    
    var 주차장명: String
    var 주차장유형: String
    var 주차장지번주소: String
    var 지역구분: String
    var 지역구분_sub: String
//    var 지역중심좌표_X좌표: String
//    var 지역중심좌표_Y좌표: String
    var 지역코드: String
    var 토요일운영시작시각: String
    var 토요일운영종료시각: String
}
