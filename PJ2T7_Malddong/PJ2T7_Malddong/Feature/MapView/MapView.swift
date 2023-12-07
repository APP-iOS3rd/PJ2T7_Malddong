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
        ZStack {
            UIMapView()
                .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct UIMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
      
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//    NMFAuthManager.shared().clientId = "YOUR_CLIENT_ID_HERE"
//
//    return true
//
//}

#Preview {
    MapView()
}
