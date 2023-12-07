//
//  SpotListModel.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/07.
//

import Foundation

struct TouristResult: Codable {
    let result: String
    let infoCnt: Int
    let info: [Info]

    enum CodingKeys: String, CodingKey {
        case result
        case infoCnt = "info_cnt"
        case info
    }
}

struct Info: Codable, Hashable {
    let contentsID: String
    let contentsLabel: String
    let title, address, roadAddress, tag: String
    let introduction: String
    let latitude, longitude: Double
    let postCode, phoneNo: String
    let imgPath, thumbnailPath: String

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

