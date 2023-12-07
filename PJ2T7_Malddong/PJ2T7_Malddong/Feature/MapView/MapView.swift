//
//  MapView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

import NMapsMap

struct MapView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            UIMapView()
                .edgesIgnoringSafeArea(.vertical)
//            Text("")
//                .edgesIgnoringSafeArea(.vertical)
//            
            HStack {
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 80, height: 36)
                            .background(Color(red: 1, green: 0.89, blue: 0.5))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
                        HStack {
                            Image("tissue")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 28, height: 28)
                                .clipped()
                            
                            Text("화장실")
                                .font(
                                    Font.custom("LINE Seed Sans KR", size: 12)
                                        .weight(.bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(12)
            
            
        }.onAppear {
            NMFAuthManager.shared().clientId = getValueOfPlistFile("ApiKeys", "CLIENT_ID")
        }
    }
}

struct UIMapView: UIViewRepresentable {
    typealias UIViewType = NMFNaverMapView
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        
        NMFAuthManager.shared().clientId = getValueOfPlistFile("ApiKeys", "CLIENT_ID")
        
        let mapView = NMFNaverMapView()
        mapView.showZoomControls = false
        mapView.mapView.positionMode = .direction
        mapView.mapView.zoomLevel = 17
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}


func getValueOfPlistFile(_ plistFileName:String,_ key:String) -> String? {
    guard let filePath =
            Bundle.main.path(forResource: plistFileName, ofType: "plist") else {
        fatalError("Couldn't find file '\(plistFileName).plist'")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    
    guard let value = plist?.object(forKey: key) as? String else{
        fatalError("Couldn't find key '\(key)'")
    }
    return value
}


#Preview {
    MapView()
}
