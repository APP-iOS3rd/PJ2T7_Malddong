//
//  TouristResorViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation
class SpotViewModel: ObservableObject {
    @Published var spotitem = [Spot]()
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    var distributeArea : [String]
    
        private var touristApiKey: String? {
            get { getValueOfPlistFile("ApiKeys", "TOURIST_API_KEY") }
        }
    
    
    init(
        spotitem: [Spot] = [],
        distributeSelect: String = "제주시",
        isGridAlign: Bool = true,
        distributeArea: [String] = ["제주시","서귀포시"]
        
    ){
        self.spotitem = spotitem
        self.distributeSelect = distributeSelect
        self.isGridAlign = isGridAlign
        self.distributeArea = distributeArea
    }
    
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
                    }
                } catch let error {
                    print("여기 : " + error.localizedDescription)
                }
                
            }
            task.resume()
        }
    
   
    
}

