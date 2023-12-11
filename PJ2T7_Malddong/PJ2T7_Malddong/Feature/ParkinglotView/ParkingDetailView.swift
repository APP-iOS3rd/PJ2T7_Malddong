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
        Text("Parking Detail: \(parking.주차장명)")
    }
}

#Preview {
    ParkingDetailView(parking: <#Parking#>)
}
