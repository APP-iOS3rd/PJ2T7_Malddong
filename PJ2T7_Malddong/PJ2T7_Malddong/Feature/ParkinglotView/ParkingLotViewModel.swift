//
//  ParkingLotViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation

class ParkingLotViewModel: ObservableObject {
    static let shared = ParkingLotViewModel()

    @Published var parkingLots: [Parking]
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    @Published var filteredParkingList: [Parking] = []
    
    var distributeArea : [String]
    
    private init(){
        self.parkingLots = [Parking]()
        self.distributeSelect = "제주시"
        self.isGridAlign = true
        self.distributeArea = ["제주시","서귀포시"]
    }
    
    let apiKey = "PARKING_API_KEY"
    
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
    
    func fetchData(){
        guard let apiKey = apikey else { return }

        let urlString = 
        "https://api.odcloud.kr/api/15050093/v1/uddi:d19c8e21-4445-43fe-b2a6-865dff832e08?page=1&perPage=600&cond%5B%EC%A7%80%EC%97%AD%EC%BD%94%EB%93%9C%3A%3AEQ%5D=50110&serviceKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        

        let task = session.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Results.self, from: data)
                print(json.data)
                
                DispatchQueue.main.async {
                    self.parkingLots = json.data
                    self.resetFilter()
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    // 검색 기능
    func filterByName(_ parkingName: String){
        filteredParkingList = parkingLots.filter { parking in
            return parking.name.lowercased().contains(parkingName.lowercased())
        }
    }
    
    func resetFilter() {
        filteredParkingList = parkingLots
    }
}
