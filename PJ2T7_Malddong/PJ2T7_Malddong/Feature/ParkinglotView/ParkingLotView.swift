//
//  ParkingLotListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ParkingLotView: View {
    @StateObject private var parkingLotViewModel = ParkingLotViewModel(parkingLots: [])
    
    var body: some View {
        ScrollView{
            VStack{
                distributeView(
                    parkingLotViewModel: parkingLotViewModel)
                .padding(.horizontal)
                
                GridView(parkingLotViewModel: parkingLotViewModel)
                    .padding()
            }
        }
        .onAppear{
            parkingLotViewModel.fetchData()
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
            ForEach(parkingLotViewModel.parkingLots,id: \.self){item in
                ParkingCellView(parkingLotViewModel: parkingLotViewModel, item: item)
                    .padding()
            }
        }).animation(.default)
    }
}

// ParkingCellView
private struct ParkingCellView:View{
    @ObservedObject private var parkingLotViewModel: ParkingLotViewModel
    private var item: Parking
    
    init(parkingLotViewModel: ParkingLotViewModel, item: Parking) {
        self.parkingLotViewModel = parkingLotViewModel
        self.item = item
    }
    
    var body: some View{
        VStack(spacing:0){
            if parkingLotViewModel.isGridAlign{
                ZStack{
                    
                    
                    Rectangle()
                        .frame(width: 152,height: 100)
                        .foregroundColor(.gray)
                        //.cornerRadius(15, corners: [.topLeft, .topRight])
                        .shadow(radius: 7)
                    
//                    AsyncImage(url: URL(string:
//                                            ParkingLotViewModel.imageNilCheck(item)
//                                       )){
//                        $0.image?.resizable()
//                                }
                        
                        .scaledToFit()
                        .frame(maxWidth: 152,maxHeight: 100)
                }
                ZStack{
                    Rectangle()
                        .frame(width: 152,height: 70)
                        .foregroundColor(.white)
                        // .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .shadow(radius: 7)
                    
                    VStack{
                        Text(item.주차장명)
                            .font(.system(size: 15,weight: .bold))
                        
                        HStack{
                            Text(item.주차장도로명주소)
                                .frame(width: 70)
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .foregroundStyle(Color.gray)
                            
                            Text("1.2km") // 거리 설정
                        }
                        
                    }.frame(maxWidth: 152,maxHeight: 70)
                }
            }else{
                HStack(spacing:0){
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 210, height: 180)
                            .foregroundStyle(Color.gray)
                            //.cornerRadius(15,corners: [.topLeft,.bottomLeft])
                            .shadow(radius: 7)
                        
//                        AsyncImage(url: URL(string:
//                                                ParkingLotViewModel.imageNilCheck(item)
//                                           )){
//                            $0.image?.resizable()
//                        }
                            .scaledToFit()
                            .frame(maxWidth: 210,maxHeight: 180)
                            
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 160, height: 180)
//                            .cornerRadius(15,corners:
//                                            [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack{
                            Text(item.주차장명)
                                .font(.system(size: 20,weight: .bold))
                            Text("1.6km")
                            Text(item.주차장도로명주소)
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
