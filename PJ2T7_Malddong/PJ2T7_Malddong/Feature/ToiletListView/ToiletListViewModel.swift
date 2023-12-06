//
//  ToiletViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation


class ToiletListViewModel:ObservableObject{
    @Published var toiletList: [Toilet]
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    var distributeArea : [String]
    
  
    init(toiletList: [Toilet] = [
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false),
        Toilet(toiletImage: "dolhareubang", toiletName: "화장실이름", toiletAddress: "서귀포시 중산간동로 8462-2 (서호동, 서귀포시산림조합)", toiletDistance: "1.2km", like: false)
    ],
         distributeSelect: String = "서귀포시",
         gridAlign: Bool = false,
         distributeArea: [String] = ["제주시","서귀포시"]
    ) {
        self.toiletList = toiletList
        self.distributeSelect = distributeSelect
        self.isGridAlign = gridAlign
        self.distributeArea = distributeArea
    }
}
extension ToiletListViewModel{
    //TODO: - 우 상단에 피커를 선택했을때 동네별로 분류해야함
    
    func gridOneLine(){
        isGridAlign = false
    }
    func gridTwoLine(){
        isGridAlign = true
    }
}

