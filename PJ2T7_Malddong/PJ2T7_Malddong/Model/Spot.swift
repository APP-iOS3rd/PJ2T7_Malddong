//
//  Spot.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/11.
//

import Foundation

struct SpotResult: Codable {
    var result: String
    var infoCnt: Int
    var info: [Spot]

    enum CodingKeys: String, CodingKey {
        case result
        case infoCnt = "info_cnt"
        case info
    }
}

struct Spot: Codable, Hashable {
    var contentsID: String
    var contentsLabel: String
    var title, address, roadAddress, tag: String     // 제목, 주소, 도로명 주소, 태그
    var introduction: String                         // 관광지 소개
    var latitude, longitude: Double                  // 위도와 경도
    var postCode, phoneNo: String                    // 우편번호 및 전화번호
    var imgPath, thumbnailPath: String         // 이미지 및 썸네일 경로

    enum CodingKeys: String, CodingKey {
        case contentsID = "contents_id"
        case contentsLabel = "contents_label"
        case title, address
        case roadAddress = "road_address"
        case tag, introduction, latitude, longitude
        case postCode = "post_code"
        case phoneNo = "phone_no"
        case imgPath = "img_path"
        case thumbnailPath = "thumbnail_path"
    }
}
