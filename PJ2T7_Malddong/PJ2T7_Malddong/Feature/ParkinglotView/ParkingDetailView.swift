//
//  ParkingDetailView.swift
//  PJ2T7_Malddong
//
//  Created by 김수비 on 12/11/23.
//

import SwiftUI

struct ParkingDetailView: View {
    var parking: Parking
    
    var body: some View {
        ScrollView {
            VStack {
                
                Image("주차장")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320,maxHeight: 180)
                    .background(Color.blue)
                
                // 지도자리
                Image("주차장")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320,maxHeight: 180)
                    .background(Color.blue)
                
                ParkingInfoSection(title: "\(parking.운영요일)", content: Color.gray, fontSize: 15, alignment: .trailing)
                
                ParkingInfoSection(title: "\(parking.주차장명)", content: .black, fontSize: 25, alignment: .leading)
                ParkingInfoSection(title: "\(parking.주차장도로명주소)", content: Color.gray, fontSize: 15, alignment: .leading, bottomPadding: 10)
                
                HStack(alignment: .center, spacing: 50){
                    ParkingDetailItem(title: "전화번호", value: "\(parking.연락처)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "주차구획수", value: "\(parking.주차구획수)", titleColor: .red, valueColor: .gray, alignment: .trailing)
                }.padding()
                
                HStack(alignment: .center, spacing: 50) {
                    ParkingDetailItem(title: "요금정보", value: "\(parking.요금정보)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "관리기관명", value: "\(parking.관리기관명)", titleColor: .red, valueColor: .gray, alignment: .trailing)
                }
                
                HStack(alignment: .center, spacing: 50)
                {
                    ParkingDetailItem(title: "구분", value: "\(parking.주차장구분)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "유형", value: "\(parking.주차장유형)", titleColor: .red, valueColor: .gray, alignment: .trailing)
                }
                
            }
        }
    }
}


private func ParkingInfoSection(title: String, content: Color, fontSize: CGFloat, alignment: Alignment = .center, bottomPadding: CGFloat = 0) -> some View {
    VStack {
        Text(title)
            .foregroundColor(content)
            .font(.custom("LINESeedKR-Rg", size: fontSize))
            .frame(maxWidth:320, alignment: alignment)
            .padding(.bottom, bottomPadding)
    }
}


private func ParkingDetailItem(title: String, value: String, titleColor: Color, valueColor: Color, alignment: Alignment = .center) -> some View {
    VStack {
        Text(title)
            .foregroundColor(titleColor)
        Text(value)
            .foregroundColor(valueColor)
            .font(.custom("LINESeedKR-Rg", size: 13))
        
    }
    .frame(maxWidth: .infinity)
    .padding()
}

//#Preview {
//    ParkingDetailView()
//}
