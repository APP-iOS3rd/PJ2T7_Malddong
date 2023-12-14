//
//  ToiletViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation
import CoreLocation
import UIKit

class ToiletListViewModel:ObservableObject{
    static let shared = ToiletListViewModel()
    
    @Published var toiletList: [Toilet]
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    @Published var filteredToiletList: [Toilet] = []

    var distributeArea : [String]
    
    
    let api_key = "TOILET_API_KEY"
    private var apiKey: String? {
        get{ getValueOfPlistFile("ApiKeys",api_key)}
    }
    
    private init(){
        self.toiletList = [Toilet]()
        self.distributeSelect = "전체"
        self.isGridAlign = true
        self.distributeArea = ["전체","한경면","한림읍","애월읍","조천읍","구좌읍"]
    }
}
extension ToiletListViewModel{
    //TODO: - 우 상단에 피커를 선택했을때 동네별로 분류해야함
    
    func gridOneLine(){
        isGridAlign = false
    }
    
    func gridTwoLine(){
        isGridAlign = true
    }
    
    func fetchData(){
        guard let apiKey = apiKey else {return}
        
        let urlString =
        "https://apis.data.go.kr/6510000/publicToiletService/getPublicToiletInfoList?pageNo=1&numOfRows=500&serviceKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as?
                    HTTPURLResponse,response.statusCode == 200 else {
                print("status code is not 200")
                return
            }
            
            guard let data = data else {
                print("No dadta reseived")
                return
            }
            
            do{
                let json = try JSONDecoder().decode(ToiletResponse.self, from: data)
                
                DispatchQueue.main.async{
                    self.toiletList = json.response.body.items.item
                    self.resetFilter()
                }
            }catch let error{
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }//fetch
    
    
    func getValueOfPlistFile(_ plistFileName:String,_ key:String) -> String?{
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
    
    func imageNilCheck(_ toilet:Toilet) -> String{
        guard let toilet = toilet.photo else{
            return "dolhareubang"
        }
        return toilet[0]
    }
    func distanceCalc(toilet:Toilet)->String{
        let manager = CLLocationManager()
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        let lat = manager.location?.coordinate.latitude
        let lo = manager.location?.coordinate.longitude
        
        let myLocation = CLLocation(latitude: lat ?? 37.0, longitude: lo ?? 127.0)
        
        let objectLoaction = CLLocation(latitude: Double(toilet.laCrdnt) ?? 3.0, longitude: Double(toilet.loCrdnt) ?? 127.0)
        
        let distanceMetor = myLocation.distance(from: objectLoaction)
        
        return String(Int(distanceMetor)/1000)
        
    }
    
    // 검색 기능
    func filterByName(_ toiletName: String){
        filteredToiletList = toiletList.filter { toilet in
            return toilet.toiletNm.lowercased().contains(toiletName.lowercased())
        }
    }
    
    func resetFilter() {
        filteredToiletList = toiletList
    }
}


