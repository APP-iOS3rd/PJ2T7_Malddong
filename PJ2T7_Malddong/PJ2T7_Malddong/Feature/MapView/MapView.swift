//
//  MapView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

import NMapsMap
import CoreLocation

struct MapView: View {
    
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

struct UIMapView: UIViewRepresentable {
    @ObservedObject var toiletListViewModel = ToiletListViewModel()
    @ObservedObject var spotViewModel = SpotViewModel(spotitem: [])
    @ObservedObject var parkingLotViewModel =  ParkingLotViewModel(parkingLots: [])
    
    @State private var isToiletInfoWindowTouched = false
    @State private var isSpotInfoWindowTouched = false
    @State private var isParkingInfoWindowTouched = false
    
    typealias UIViewType = NMFNaverMapView
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        
        toiletListViewModel.fectchData()
        parkingLotViewModel.fetchData()
        spotViewModel.fetchData()
        
        NMFAuthManager.shared().clientId = getValueOfPlistFile("ApiKeys", "CLIENT_ID")
        
        let mapView = NMFNaverMapView()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 33.4996213, lng: 126.5311884))
        
        mapView.showZoomControls = false
        mapView.mapView.positionMode = .direction
        mapView.mapView.zoomLevel = 14
        mapView.mapView.moveCamera(cameraUpdate)
        
        return mapView
    }
    
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
        toiletListViewModel.toiletList.forEach {
            connectMarker(title: $0.toiletNm, latitude: Double($0.laCrdnt), longitude: Double($0.loCrdnt), color: .malddongYellow)
        }
        
        parkingLotViewModel.parkingLots.forEach {
            connectMarker(title: $0.name, latitude: Double($0.latitude), longitude: Double($0.longitude), color: .malddongBlue)
        }
        
        spotViewModel.spotitem.forEach {
            connectMarker(title: $0.title, latitude: $0.latitude, longitude: $0.longitude, color: .malddongGreen)
        }
        

        
        
        
        // MARK: Marker 찍기
        func connectMarker( title:String, latitude: Double?, longitude: Double?, color: UIColor) {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: latitude ?? 3.0 , lng: longitude ?? 127.0)
            marker.mapView = uiView.mapView
            marker.width = 30
            marker.height = 40
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            marker.iconTintColor = color
            
            connectInfoWindow(title: title, marker: marker)
        }
        
        // MARK: InfoWindow 연결하기
        func connectInfoWindow(title: String, marker: NMFMarker) {
            
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()
            
            dataSource.title = title
            infoWindow.dataSource = dataSource
            marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                if let marker = overlay as? NMFMarker {
                    if marker.infoWindow == nil {
                        // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                        infoWindow.open(with: marker)
                    } else {
                        // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                        infoWindow.close()
                    }
                }
                return true
            }
            
            infoWindow.touchHandler = { (overlay: NMFOverlay) -> Bool in
                // 여기에 터치 이벤트 발생 시 실행할 코드를 작성합니다.
//                NavigationLink()
                return true  // true를 반환하면 이벤트가 더 이상 전달되지 않습니다.
            }
            
            
            // TODO: 지도를 탭하면 정보 창을 닫음
            func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
                infoWindow.close()
            }
        }
    }
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


