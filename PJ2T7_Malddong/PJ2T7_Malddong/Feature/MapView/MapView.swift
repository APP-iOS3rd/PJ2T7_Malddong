//
//  MapView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

import CoreLocation
import NMapsMap

struct MapView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            UIMapView()
                .edgesIgnoringSafeArea(.vertical)
   
            HStack {
                customButton(title: "화장실", imageName: "tissue", backgroundColor: .malddongYellow)
                
                customButton(title: "관광지", imageName: "dolhareubang", backgroundColor: .malddongGreen)
                
                customButton(title: "주차장", imageName: "car", backgroundColor: .malddongBlue)
                
                Spacer()
                
                Image("search")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                    .clipped()
            }
            .padding(12)
        }
    }
}

public struct customButton: View {
    let title: String
    let imageName: String
    let backgroundColor: Color
    
    public init(
        title: String,
        imageName: String,
        backgroundColor: Color
    ) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 36)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
                HStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipped()
                    
                    Text(title)
                        .foregroundStyle(.white)
                        .font(
                            Font(UIFont.LINESeedKR(size: 12, weight: .bold)))
                }
            }
        }
    }
}

#Preview {
    MapView()
}


