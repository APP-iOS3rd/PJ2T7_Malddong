//
//  SpotDetailView.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/13.
//

import SwiftUI

struct SpotDetailView: View {
    var spot: Spot
    
    var body: some View {
        ScrollView {
            VStack {
                
                AsyncImage(url: URL(string:
                                        spot.thumbnailPath
                        )){
                    $0.image?.resizable()
                }
                                   .scaledToFit()
                                   .frame(maxWidth: 320,maxHeight: 180)
                
                // 지도자리
                Image("")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320,maxHeight: 180)
                    .background(Color.blue)
                
                SpotInfoSection(title: "\(spot.tag)", content: Color.gray, fontSize: 13, alignment: .trailing)
                    
               
                Spacer()
                
                SpotInfoSection(title: "\(spot.title)", content: .black, fontSize: 20, alignment: .leading, bottomPadding: 1)
                SpotInfoSection(title: "\(spot.address)", content: Color.gray, fontSize: 15, alignment: .leading)
                SpotInfoSection(title: "\(spot.roadAddress)", content: Color.gray, fontSize: 10, alignment: .leading, bottomPadding: 10)
                
                VStack(alignment: .center, spacing: 0){
                    SpotInfoSection(title: "전화번호", content: .red, fontSize: 15, alignment: .leading)
                    SpotInfoSection(title: "\(spot.phoneNo)", content: .gray, fontSize: 13, alignment: .leading)
                }.padding()
                
                VStack(alignment: .center, spacing: 0){
                    SpotInfoSection(title: "소개", content: .red, fontSize: 15, alignment: .leading)
                    SpotInfoSection(title: "\(spot.introduction)", content: .gray, fontSize: 13, alignment: .leading)
                }.padding()
            }
        }
    }
}


private func SpotInfoSection(title: String, content: Color, fontSize: CGFloat, alignment: Alignment = .center, bottomPadding: CGFloat = 0) -> some View {
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


//#Preview {
//    SpotDetailView()
//}
