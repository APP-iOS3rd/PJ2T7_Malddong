//
//  ToiletDetailView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ToiletDetailView: View {
    
    @State private var item:Toilet
    @State private var toiletListViewModel:ToiletListViewModel
    init(item: Toilet, toiletListViewModel: ToiletListViewModel) {
        self.item = item
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                AsyncImage(url: URL(string:
                                        toiletListViewModel.imageNilCheck(item)
                                   )
                ){
                    $0.image?.resizable()
                }
                    .frame(width: 350,height: 250)
                
            
                UIMapView()
                    .frame(width: 350,height: 250)
                    
                HStack{
                    Text(item.toiletNm)
                        .font(.system(size: 20,weight: .bold))
                    Spacer()
                    Text(item.opnTimeInfo)
                        .font(.system(size: 15))
                }
                Text(item.rnAdres)
            }
            .padding()
            HStack{
                VStack(alignment:.leading){
                    toiletInforView(text: "남자화장실", closet: item.maleClosetCnt, urinal: item.maleUrinalCnt, image: "male")
                    toiletInforView(text: "남자 장애인 화장실", closet: item.maleDspsnClosetCnt, urinal: item.maleDspsnUrinalCnt, image: "maleDspsn")
                    toiletInforView(text: "남자 어린이 화장실", closet: item.maleChildClosetCnt, urinal: item.maleChildUrinalCnt, image: "maleChild")
                }
                VStack(alignment:.leading){
                    toiletInforView(text: "여자화장실", closet: item.femaleClosetCnt, urinal: item.maleUrinalCnt, image: "female")
                    toiletInforView(text: "여자 장애인 화장실", closet: item.femaleDspsnClosetCnt, urinal: item.maleUrinalCnt, image: "femaleDspsn")
                    toiletInforView(text: "여자 어린 화장실", closet: item.femaleChildClosetCnt, urinal: item.maleUrinalCnt, image: "femaleChild")
                }
            }
            
        }
    }
}
//MARK: -- 화장실별 대변기,소변기 개수 뷰
private struct toiletInforView:View{
    private var text:String = "남자화장실"
    
    private var closet:String = "1"//대변기
    private var urinal:String = "0"//소변기
    private var image:String = "male"
    
    init(
        text: String,
        closet: String,
        urinal: String,
        image: String
    ) {
        self.text = text
        self.closet = closet
        self.urinal = urinal
        self.image = image
    }
    
    
    fileprivate var body: some View{
        VStack(alignment:.leading,spacing: 0){
            HStack(spacing:0){
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                Text(text)
                    .font(.system(size: 15,weight: .bold))
                    .foregroundStyle(
                        text.contains("남자")
                        ? Color.blue
                        : Color.red)
            }
            
            HStack(spacing:0){
                Image("closet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                Text("대변기 수: \(closet)")
                    .font(.system(size: 15,weight: .bold))
                    .foregroundStyle(Color.gray)
            }
            
                HStack(spacing:0){
                    Image("urinal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                    Text("소변기 수: \(urinal)")
                        .font(.system(size: 15,weight: .bold))
                        .foregroundStyle(Color.gray)
                        
                }
                .opacity(text.contains("남자") ? 1 : 0)
            
            
            
        }
    }
}

#Preview {
    ToiletDetailView(item: Toilet(dataCd: "", laCrdnt: "", loCrdnt: "", rnAdres: "제주특별자치도 제주시 한라대학로63", toiletNm: "GS25제주한라점", opnTimeInfo: "연중무휴", mngrInsttNm: "1", telno: "1", maleClosetCnt: "1", maleUrinalCnt: "1", maleDspsnClosetCnt: "1", maleDspsnUrinalCnt: "1", maleChildClosetCnt: "1", maleChildUrinalCnt: "1", femaleClosetCnt: "1", femaleChildClosetCnt: "1", femaleDspsnClosetCnt: "1"),toiletListViewModel: ToiletListViewModel())
}
