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
}
