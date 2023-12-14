//
//  ParkingLotListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ParkingLotView: View {
    @StateObject private var parkingLotViewModel = ParkingLotViewModel.shared
    
    var filteredParkingList: [Parking] {
        parkingLotViewModel.filteredParkingList
    }
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    // 지역에 따라 분류하는 view
                    distributeView(
                        parkingLotViewModel: parkingLotViewModel)
                    .padding(.horizontal)
                    
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
    
    var body: some View{
        HStack{
            Button(action: {
                parkingLotViewModel.gridOneLine()
            }, label: {
                Image(systemName: "square.fill.text.grid.1x2")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            
            Button(action: {
                parkingLotViewModel.gridTwoLine()
            }, label: {
                Image(systemName: "square.grid.2x2.fill")
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
                
                if parkingLotViewModel.distributeSelect == "전체"{
                    
                    NavigationLink(destination: ParkingDetailView(parking: item)){
                        
                        ParkingCellView(parkingLotViewModel: parkingLotViewModel, item: item)
                    }
                } else if item.lnmAdres.contains(parkingLotViewModel.distributeSelect){
                    ParkingCellView(parkingLotViewModel: parkingLotViewModel, item:item)
                        .padding()
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
    
    var body: some View{
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
                        
                        HStack{
                            Text(item.rnAdres)
                                .frame(width: 70)
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .foregroundStyle(Color.gray)

                            Text("\(parkingLotViewModel.distanceCalc(parking: item))km")
                                .foregroundStyle(Color.gray)
                        }
                    }.frame(maxWidth: 152,maxHeight: 70)
                    
                }
                // 큰 그리드 경우
            } else{
                HStack(spacing:0){
                    ZStack{
                        Rectangle()
                            .frame(width: 210,height: 180)
                            .foregroundColor(Color("White"))
                            .cornerRadius(15, corners: [.topLeft, .topRight])
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
                    ZStack{
                        Rectangle()
                            .frame(width: 160, height: 180)
                            .cornerRadius(15,corners:
                                            [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack{
                            Text(item.name)
                                .font(.system(size: 20,weight: .bold))
                                .foregroundStyle(Color.black)
                                .padding(10)
                          
                            Text("\(parkingLotViewModel.distanceCalc(parking: item))km")
                                .foregroundStyle(Color.gray)

                            Text(item.rnAdres)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.gray)
                        }
                    }
                }//H
            }
        }
    }
}

#Preview {
    ParkingLotView()
}
