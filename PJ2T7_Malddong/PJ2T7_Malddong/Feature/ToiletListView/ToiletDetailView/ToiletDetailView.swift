//
//  ToiletDetailView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ToiletDetailView: View {
    
    @State private var item:Toilet
    @StateObject private var toiletListViewModel = ToiletListViewModel.shared
    
    init(item: Toilet) {
        self.item = item
    }
    
//    init(item: Toilet, toiletListViewModel: ToiletListViewModel) {
//        self.item = item
//        self.toiletListViewModel = toiletListViewModel
//    }
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string:
                                        toiletListViewModel.imageNilCheck(item)
                                   )
                ){
                    $0.image?.resizable()
                }
                .frame(width: 350,height: 250)
                
                UIMiniMapView(title: "\(item.toiletNm)", latitude: Double("\(item.laCrdnt)")!, longitude: Double("\(item.loCrdnt)")!)
                    .frame(width: 350,height: 250)
                    .scaledToFit()
                
                ToiletInfoSection(title: "\(item.opnTimeInfo)", content: Color.gray, fontSize: 13, alignment: .trailing)
                
                Spacer()
                
                ToiletInfoSection(title: "\(item.toiletNm)", content: Color.black, fontSize: 20, alignment: .leading, bottomPadding: 1)
                ToiletInfoSection(title: "\(item.lnmAdres)", content: Color.gray, fontSize: 15, alignment: .leading)

                HStack {
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
                }.padding()

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
                    .font(.custom("LINESeedKR-Bd", size: 14))
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
                    .font(.custom("LINESeedKR-Bd", size: 14))
                    .foregroundStyle(Color.gray)
            }
            
            HStack(spacing:0){
                Image("urinal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                Text("소변기 수: \(urinal)")
                    .font(.custom("LINESeedKR-Bd", size: 14))
                    .foregroundStyle(Color.gray)
                
            }
            .opacity(text.contains("남자") ? 1 : 0)
        }
    }
}

private func ToiletInfoSection(title: String, content: Color, fontSize: CGFloat, alignment: Alignment = .center, bottomPadding: CGFloat = 0) -> some View {
    VStack {
        Text(title)
            .foregroundColor(content)
            .font(.custom("LINESeedKR-Bd", size: fontSize))
            .frame(maxWidth:320, alignment: alignment)
            .padding(.bottom, bottomPadding)
            .italic() //이텔릭체가 적용이 X
        // Font(UIFont.LINESeedKR(size: 12, weight: .bold)))
        
    }
}


#Preview {
    ToiletDetailView(item: Toilet(dataCd: "pt0001", laCrdnt: "33.44980872", loCrdnt: "126.6182481",  lnmAdres: "제주특별자치도 제주시 봉개동 237-2", toiletNm: "", opnTimeInfo: "", mngrInsttNm: "", telno: "", maleClosetCnt: "", maleUrinalCnt: "", maleDspsnClosetCnt: "", maleDspsnUrinalCnt: "", maleChildClosetCnt: "", maleChildUrinalCnt: "", femaleClosetCnt: "", femaleChildClosetCnt: "", femaleDspsnClosetCnt: ""), toiletListViewModel:ToiletListViewModel() )
}
