//
//  Parking.swift
//  PJ2T7_Malddong

import Foundation

struct Results: Decodable {
    let currentCount: Int
    let data: [Parking]
}

struct Parking: Hashable, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case latitude = "위도"
        case longitude = "경도"
        case manageName = "관리기관명"
        case phoneNo = "연락처"
        case price = "요금정보"
        case operatingDays = "운영요일"
        case enableNum = "주차구획수"
        case isPublic = "주차장구분"
        case rnAdres = "주차장도로명주소"
        case name = "주차장명"
        case type = "주차장유형"
        case lnmAdres = "주차장지번주소"
    }
    
    var latitude: String
    var longitude: String
    var manageName: String
    var phoneNo: String
    var price: String
    var operatingDays: String
    var enableNum: String
    var isPublic: String
    var rnAdres: String
    var name: String
    var type: String
    var lnmAdres: String
}
