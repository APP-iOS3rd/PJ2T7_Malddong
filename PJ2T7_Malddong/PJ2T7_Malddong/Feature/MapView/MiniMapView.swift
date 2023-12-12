//
//  MiniMapView.swift
//  PJ2T7_Malddong
//
//  Created by 이종원 on 12/12/23.
//

import SwiftUI

import NMapsMap

struct MiniMapView: View {
    var body: some View {
        // UIMiniMapView 사용 예제
        UIMiniMapView(title: "화장실", latitude: 37.5666102, longitude: 126.9783881)
            .frame(width: 350, height: 200)
    }
}

struct UIMiniMapView: UIViewRepresentable {
    var title: String
    var latitude: Double
    var longitude: Double
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        
        NMFAuthManager.shared().clientId = getValueOfPlistFile("ApiKeys", "CLIENT_ID")
        
        let view = NMFNaverMapView()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        view.mapView.moveCamera(cameraUpdate)
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let marker = NMFMarker()

        marker.position = NMGLatLng(lat: latitude , lng: longitude)
        marker.mapView = uiView.mapView
        marker.width = 30
        marker.height = 40
        marker.iconImage = NMF_MARKER_IMAGE_RED

        marker.captionAligns = [NMFAlignType.top]
        marker.captionOffset = 2
        marker.captionColor = UIColor.blue
        marker.captionHaloColor = UIColor(red: 200.0/255.0, green: 1, blue: 200.0/255.0, alpha: 1)
        marker.captionText = title
    }
}

#Preview {
    MiniMapView()
}
