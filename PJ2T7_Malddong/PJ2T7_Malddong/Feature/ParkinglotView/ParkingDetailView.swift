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
                UIMiniMapView(title: "\(parking.name)", latitude: Double("\(parking.latitude)")!, longitude: Double("\(parking.longitude)")!)
                    .scaledToFit()
                    .frame(maxWidth: 320,maxHeight: 360)
                    .padding()
                
                ParkingInfoSection(title: "\(parking.operatingDays)", content: Color.gray, fontSize: 15, alignment: .trailing)
                
                ParkingInfoSection(title: "\(parking.name)", content: .black, fontSize: 20, alignment: .leading)
                ParkingInfoSection(title: parking.rnAdres, content: Color.gray, fontSize: 15, alignment: .leading, bottomPadding: 10)
                
                HStack(alignment: .center, spacing: 50){
                    ParkingDetailItem(title: "전화번호", value: "\(parking.phoneNo)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "주차구획수", value: "\(parking.enableNum)", titleColor: .red, valueColor: .gray, alignment: .trailing)
                }.padding()
                
                HStack(alignment: .center, spacing: 50) {
                    ParkingDetailItem(title: "요금정보", value: "\(parking.price)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "관리기관명", value: "\(parking.manageName)", titleColor: .red, valueColor: .gray, alignment: .trailing)
                }
                
                HStack(alignment: .center, spacing: 50)
                {
                    ParkingDetailItem(title: "구분", value: "\(parking.isPublic)", titleColor: .red, valueColor: .gray, alignment: .leading)
                    ParkingDetailItem(title: "유형", value: "\(parking.type)", titleColor: .red, valueColor: .gray, alignment: .trailing)
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
            .font(.custom("LINESeedKR-Bd", size: 15))
        
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
