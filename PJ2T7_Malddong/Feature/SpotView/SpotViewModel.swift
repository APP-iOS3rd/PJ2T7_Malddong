//
//  TouristResorViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation
class SpotViewModel: ObservableObject {
        static let shared = SpotViewModel()
        private init() { }
        
        @Published var touristItem = [Info]()
        
        private var touristApiKey: String? {
            get { getValueOfPlistFile("ApiKeys", "TOURIST_API_KEY") }
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
                    let results = try JSONDecoder().decode(TouristResult.self, from: data)
                    DispatchQueue.main.async {
                        self.touristItem = results.info
                        print(results)
                    }
                } catch let error {
                    print("여기 : " + error.localizedDescription)
                }
                
            }
            task.resume()
        }
    }

