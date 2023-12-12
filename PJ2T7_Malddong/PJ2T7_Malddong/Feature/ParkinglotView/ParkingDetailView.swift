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
        VStack {
            Image("주차장")
            Image("지도")
            
            HStack{
                Text("\(parking.주차장명)")
                
                VStack{
                    Text("\(parking.주차장도로명주소)")
                    Text("300M")
                }
                
                Text("연락처")
                Text("\(parking.연락처)")
                
            }
            
        }
        
        Text("Parking Detail: \(parking.주차장명)")
    }
}

//#Preview {
//    ParkingDetailView(parking: <#Parking#>)
//}
