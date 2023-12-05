//
//  ToiletViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation


class ToiletListViewModel:ObservableObject{
    @Published var toiletList: [Toilet]
    var distributeArea : [String]
    
    init(
        toiletList: [Toilet] = [
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
            Toilet(toiletImage: "dolhareubang", toiletName: "화장실 이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false)
        
        ],
        distributeArea: [String] = ["제주시","애월읍","찰떡시","귀엽군"]
    ) {
        self.toiletList = toiletList
        self.distributeArea = distributeArea
    }
    
}

