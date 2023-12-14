//
//  MapViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

import CoreLocation
import NMapsMap
import MapKit

//class MapViewModel: ObservableObject {
//    @ObservedObject var toiletListViewModel = ToiletListViewModel()
//    @ObservedObject var spotViewModel = SpotViewModel(spotitem: [])
//    @ObservedObject var parkingLotViewModel =  ParkingLotViewModel(parkingLots: [])
//    
//    @State var stackPath = NavigationPath()
//}

struct UIMapView: UIViewRepresentable {
    @ObservedObject var toiletListViewModel = ToiletListViewModel()
    @ObservedObject var spotViewModel = SpotViewModel(spotitem: [])
    @ObservedObject var parkingLotViewModel =  ParkingLotViewModel(parkingLots: [])
    
//    let mapViewModel = MapViewModel()
    
    @State private var isToiletInfoWindowTouched = false
    @State private var isSpotInfoWindowTouched = false
    @State private var isParkingInfoWindowTouched = false
    
    let locationManger = CLLocationManager()
    
    typealias UIViewType = NMFNaverMapView
    
    // MARK: 내 위치
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        NMFAuthManager.shared().clientId = getValueOfPlistFile("ApiKeys", "CLIENT_ID")
        
        let coodinator = makeCoordinator()
        coodinator.checkLocationAuthorization()
        coodinator.checkIfLocationServiceIsEnabled()
        coodinator.fetchUserLocation()
        
        toiletListViewModel.fetchData()
        parkingLotViewModel.fetchData()
        spotViewModel.fetchData()
        
        let mapView = NMFNaverMapView()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 33.4996213, lng: 126.5311884))
        
        mapView.showZoomControls = false
        mapView.mapView.positionMode = .normal
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
        
        func connectMarker(title:String, latitude: Double?, longitude: Double?, color: UIColor) {
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
                
                return true  // true를 반환하면 이벤트가 더 이상 전달되지 않습니다.
            }
            
            // TODO: 지도를 탭하면 정보 창을 닫음
            func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
                infoWindow.close()
            }
        }
    }
    
    final class Coordinator: NSObject, ObservableObject,NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
        static let shared = Coordinator()
        @Published var coord: (Double, Double) = (0.0, 0.0)
        @Published var userLocation: (Double, Double) = (0.0, 0.0)
        
        var locationManager: CLLocationManager?
        let view = NMFNaverMapView(frame: .zero)
        
        // MARK: - 위치 정보 동의 확인
        func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("위치 정보 접근이 제한되었습니다.")
            case .denied:
                print("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Success")
                
                coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
                userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
                
                fetchUserLocation()
                
            @unknown default:
                break
            }
        }
        
        func checkIfLocationServiceIsEnabled() {
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    DispatchQueue.main.async {
                        self.locationManager = CLLocationManager()
                        self.locationManager!.delegate = self
                        self.checkLocationAuthorization()
                    }
                } else {
                    print("Show an alert letting them know this is off and to go turn i on")
                }
            }
        }
        
        func fetchUserLocation() {
            if let locationManager = locationManager {
                let lat = locationManager.location?.coordinate.latitude
                let lng = locationManager.location?.coordinate.longitude
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0), zoomTo: 15)
                cameraUpdate.animation = .easeIn
                cameraUpdate.animationDuration = 1
                
                let locationOverlay = view.mapView.locationOverlay
                locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
                locationOverlay.hidden = false
                
                locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
                locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
                locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
                locationOverlay.anchor = CGPoint(x: 0.5, y: 1)
                
                view.mapView.moveCamera(cameraUpdate)
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


