//
//  ParkingLotListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData

struct ParkingLotView: View {
    @StateObject var parkingLotViewModel = ParkingLotViewModel.shared
    
    var filteredParkingList: [Parking] {
        parkingLotViewModel.filteredParkingList
    }
    var body: some View {
        NavigationStack {
            // 지역에 따라 분류하는 view
            distributeView(
                parkingLotViewModel: parkingLotViewModel)
            .padding(.horizontal)
            ScrollView {
                VStack {
                    // 네모 뷰
                    GridView(parkingLotViewModel: parkingLotViewModel)
                        .padding()
                }
            }
            .onAppear{
                parkingLotViewModel.fetchData()
            }
        }
    }
}

// distributeView
private struct distributeView:View{
    @ObservedObject private var parkingLotViewModel: ParkingLotViewModel
    
    init(parkingLotViewModel: ParkingLotViewModel) {
        self.parkingLotViewModel = parkingLotViewModel
    }
    
    var body: some View {
        HStack{
            Button(action: {
                parkingLotViewModel.gridTwoLine()
            }, label: {
                Image(systemName: "square.grid.2x2.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            
            Button(action: {
                parkingLotViewModel.gridOneLine()
            }, label: {
                Image(systemName: "square.fill.text.grid.1x2")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            
            Spacer()
            
            Picker("", selection:$parkingLotViewModel.distributeSelect
                   , content: {
                ForEach(parkingLotViewModel.distributeArea,id: \.self){item in
                    Text(item)
                }
            })
        }
    }
}

// 개별 버튼
private struct GridView:View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: MyParkings.entity(), sortDescriptors: [])
    private var myParkings: FetchedResults<MyParkings>
    
    @ObservedObject private var parkingLotViewModel: ParkingLotViewModel
    
    init(parkingLotViewModel: ParkingLotViewModel) {
        self.parkingLotViewModel = parkingLotViewModel
    }
    
    var body: some View {
        LazyVGrid(columns: parkingLotViewModel.isGridAlign ? [
            GridItem(.flexible()),
            GridItem(.flexible()),] :[GridItem(.flexible())]
                  , content: {
            
            ForEach(parkingLotViewModel.filteredParkingList,id: \.self){item in
                ZStack{
                    if parkingLotViewModel.distributeSelect == "전체"{
                        
                        NavigationLink(destination: ParkingDetailView(parking: item)){
                            
                            ParkingCellView(parkingLotViewModel: parkingLotViewModel, item: item)
                        }
                    } else if item.lnmAdres.contains(parkingLotViewModel.distributeSelect){
                        ParkingCellView(parkingLotViewModel: parkingLotViewModel, item:item)
                            .padding()
                    }
                    HStack {
                        Spacer()
                        LikeButton2(myParkings: myParkings, item: item) {
                            if let parking = myParkings.first(where: { $0.name == item.name }) {
                                parking.isLiked.toggle()
                            } else {
                                DataController().addParking(name: item.name, rnAdres: item.rnAdres, longitude: item.longitude, latitude: item.latitude, isLiked: true, context: viewContext)
                            }
                        }
                    }
                }
            }
        })
    }
}

// ParkingCellView
private struct ParkingCellView:View{
    @ObservedObject private var parkingLotViewModel: ParkingLotViewModel
    private var item: Parking
    
    let CarImages = ["car1", "car2", "car3", "car4", "car5", "car6", "car7", "car8", "car9", "car10",
                     "car11", "car12", "car13", "car14", "car15", "car16", "car17", "car18", "car19",
                     "car20", "car21", "car22", "car23", "car24", "car25", "car26"]
    
    init(parkingLotViewModel: ParkingLotViewModel, item: Parking) {
        self.parkingLotViewModel = parkingLotViewModel
        self.item = item
    }
    
    var body: some View {
        // 수직으로 나열
        VStack(spacing:0){
            // 작은 그리드 정렬
            if parkingLotViewModel.isGridAlign{
                ZStack{
                    Rectangle()
                        .frame(width: 152,height: 100)
                        .foregroundColor(Color("MalddongGray"))
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                        .shadow(radius: 7)
                    
                    ForEach(0..<26) { _ in
                        let randomIndex = Int.random(in: 0..<self.CarImages.count)
                        let imageName = self.CarImages[randomIndex]
                        
                        Image(imageName)
                            .resizable()
                            .frame(maxWidth: 152, maxHeight: 100)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: 152,height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .shadow(radius: 7)
                    
                    VStack{
                        Text(item.name)
                            .font(.system(size: 15,weight: .bold))
                            .foregroundStyle(Color.black)
                            .frame(width: 140, alignment: .leading)
                            .padding(.bottom, 3)
                        
                        Text("\(parkingLotViewModel.distanceCalc(parking: item))km")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.red)
                            .frame(width: 140, alignment: .leading)
          
                    }.frame(maxWidth: 152,maxHeight: 70)
                }
                // 큰 그리드 경우
            } else {
                HStack(spacing:0) {
                    ZStack {
                        Rectangle()
                            .frame(width: 210,height: 180)
                            .foregroundColor(Color("White"))
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                            .shadow(radius: 7)
                        
                        ForEach(0..<26) { _ in
                            let randomIndex = Int.random(in: 0..<self.CarImages.count)
                            let imageName = self.CarImages[randomIndex]
                            
                            Image(imageName)
                                .resizable()
                                .frame(maxWidth: 210, maxHeight: 180)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 160, height: 180)
                            .cornerRadius(15,corners:
                                            [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack {
                            Text(item.name)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.black)
                                .frame(width: 150, alignment: .leading)
                                .padding(.bottom, 5)
                            
                            Text("\(parkingLotViewModel.distanceCalc(parking: item))km")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.red)
                                .frame(width: 150, alignment: .leading)


                        }
                    }
                }
            }//H
        }
    }
}


#Preview {
    ParkingLotView(parkingLotViewModel: ParkingLotViewModel.shared)
}
