//
//  TouristResorViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation
import CoreLocation
class SpotViewModel: ObservableObject {
    static let shared = SpotViewModel()
    
    @Published var spotitem = [Spot]()
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    var distributeArea : [String]
    @Published var filteredSpotList: [Spot] = []
    
    private var touristApiKey: String? {
        get { getValueOfPlistFile("ApiKeys", "TOURIST_API_KEY") }
    }
    
    private init() {
        self.spotitem = [Spot]()
        self.distributeSelect = "전체"
        self.isGridAlign = true
        self.distributeArea = ["전체","한경면","한림읍","애월읍","조천읍","구좌읍"]
    }
    
//    init(
//        spotitem: [Spot] = [],
//        distributeSelect: String = "제주시",
//        isGridAlign: Bool = true,
//        distributeArea: [String] = ["제주시","서귀포시"]
//        
//    ){
//        self.spotitem = spotitem
//        self.distributeSelect = distributeSelect
//        self.isGridAlign = isGridAlign
//        self.distributeArea = distributeArea
//    }
    
    let apiKey = "TOURIST_API_KEY"
    
    private var apikey: String? {
        get {
            let keyfilename = "ApiKeys"
            
            // 생성한 .plish 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Couldn't find file '\(keyfilename).plist")
            }
            
            // .plist 파일 내용을 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 키 찾기
            guard let value = plist?.object(forKey: apiKey) as? String else {
                fatalError("Couldn't find key '\(apiKey)'")
            }
            return value
        }
    }
    
    func gridOneLine(){
        isGridAlign = false
    }
    
    func gridTwoLine(){
        isGridAlign = true
    }
    
    
    func fetchData() {
        guard let touristApiKey = touristApiKey else { return }
        
        let urlString = "http://api.jejuits.go.kr/api/infoTourList?code=\(touristApiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error : " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)

                do {
                    let results = try JSONDecoder().decode(SpotResult.self, from: data)
                    DispatchQueue.main.async {
                        self.spotitem = results.info
                        print(results)
                        self.resetFilter()
                    }
                } catch let error {
                    print("여기 : " + error.localizedDescription)
                }
            }
        task.resume()
        }
    
    // 거리 표시
    func distanceCalc(spot:Spot)->String{
        //내위치 임의 설정
        let manager = CLLocationManager()
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        let lat = manager.location?.coordinate.latitude
        let lo = manager.location?.coordinate.longitude
        
        
        let myLocation = CLLocation(latitude: lat ?? 37.0, longitude: lo ?? 127.0)
        
        let objectLoaction = CLLocation(latitude: Double(spot.latitude) ?? 3.0, longitude: Double(spot.longitude) ?? 127.0)
        
        let distanceMetor = myLocation.distance(from: objectLoaction)
        
        return String(Int(distanceMetor)/1000)   
    }
    
    // 검색 기능
    func filterByName(_ spotName: String){
        filteredSpotList = spotitem.filter { spot in
            return spot.title.lowercased().contains(spotName.lowercased())
        }
    }

    
    func resetFilter() {
        filteredSpotList = spotitem
    } 
}

