//
//  ToiletViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import Foundation
import CoreLocation


class ToiletListViewModel:ObservableObject{
    @Published var toiletList: [Toilet]
    @Published var distributeSelect: String
    @Published var isGridAlign:Bool
    var distributeArea : [String]
    
    
    let api_key = "TOILET_API_KEY"
    private var apiKey: String? {
        get{ getValueOfPlistFile("ApiKeys",api_key)}
    }
    
    init(
        toiletList: [Toilet] = [],
        distributeSelect: String = "전체",
        isGridAlign: Bool = true,
        distributeArea: [String] = [
            "전체","한경면","한림읍","애월읍","시내동","조천읍","구좌읍","우도면"]
        
    ) {
        self.toiletList = toiletList
        self.distributeSelect = distributeSelect
        self.isGridAlign = isGridAlign
        self.distributeArea = distributeArea
        
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
    
    func fectchData(){
        guard let apiKey = apiKey else {return}
        
        let urlString =
        "https://apis.data.go.kr/6510000/publicToiletService/getPublicToiletInfoList?pageNo=1&numOfRows=10&serviceKey=\(apiKey)"
        
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
        //내위치 임의 설정
        let myLocation = CLLocation(latitude: 33.44980872, longitude: 126.6182481)
        
        let objectLoaction = CLLocation(latitude: Double(toilet.laCrdnt)!, longitude: Double(toilet.loCrdnt)!)
        
        let distanceMetor = myLocation.distance(from: objectLoaction)
        
        return String(Int(distanceMetor)/1000)
        
    }
    
    
    
}


