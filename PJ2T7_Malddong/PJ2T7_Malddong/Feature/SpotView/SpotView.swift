//
//  TouristResorView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData

struct SpotView: View {
    @ObservedObject var spotViewModel: SpotViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    distributeView(spotViewModel: spotViewModel)
                        .padding(.horizontal)
                    
                    GridView(spotViewModel: spotViewModel)
                        .padding()
                }
            }
//            .onAppear{
//                spotViewModel.fetchData()
//            }
        }
    }
}

//TODO: - distributeView/grid 패턴 변경 버튼
private struct distributeView: View {
    @ObservedObject var spotViewModel: SpotViewModel
    
    init(spotViewModel: SpotViewModel) {
        self.spotViewModel = spotViewModel
    }
    
    var body: some View{
        HStack{
            Button(action: {
                spotViewModel.gridTwoLine()
            }, label: {
                Image(systemName: "square.grid.2x2.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            
            Button(action: {
                spotViewModel.gridOneLine()
            }, label: {
                Image(systemName: "square.fill.text.grid.1x2")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
                       
            Spacer()
            
            Picker("",
                   selection:$spotViewModel
                .distributeSelect
                   , content: {
                ForEach(spotViewModel
                    .distributeArea,id: \.self){item in
                        Text(item)
                        
                    }
            })
        }
    }
}

//MARK: - GrideView
private struct GridView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: MySpots.entity(), sortDescriptors: [])
    private var mySpots: FetchedResults<MySpots>
    
    @ObservedObject private var spotViewModel: SpotViewModel
    
    init(spotViewModel: SpotViewModel) {
        self.spotViewModel = spotViewModel
    }
    
    var body: some View {
        LazyVGrid(columns: spotViewModel.isGridAlign ? [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ] : [GridItem(.flexible())]
                  , content: {
            
            ForEach(spotViewModel.filteredSpotList, id: \.self) { item in
                ZStack {
                    if spotViewModel.distributeSelect == "전체"{
                        
                        NavigationLink(destination: SpotDetailView(spot: item)){
                            
                            SpotCellView(spotViewModel: spotViewModel, item: item)
                                .padding()
                        }
                    } else if item.address.contains(spotViewModel.distributeSelect){
                        SpotCellView(spotViewModel: spotViewModel, item: item)
                            .padding()
                    }
                    HStack {
                        Spacer()
                        LikeButton3(mySpots: mySpots, item: item) {
                            if let spot = mySpots.first(where: { $0.title == item.title }) {
                                spot.isLiked.toggle()
                            } else {
                                DataController().addSpot(title: item.title, thumbnailPath: item.thumbnailPath, roadAddress: item.roadAddress, longitude: item.longitude, latitude: item.latitude, isLiked: true, context: viewContext)
                            }
                        }
                    }
                    
                }
            }
            
        })
    }
}


// SpotCellView
private struct SpotCellView:View{
    @ObservedObject private var spotViewModel: SpotViewModel
    private var item: Spot
    
    init(spotViewModel: SpotViewModel, item: Spot) {
        self.spotViewModel = spotViewModel
        self.item = item
    }
    
    var body: some View{
        
        VStack(spacing:0){
            if spotViewModel.isGridAlign{
                ZStack{
                    
                    Rectangle()
                        .frame(width: 152,height: 100)
                        .foregroundColor(.gray)
                        .cornerRadius(15,corners: [.topLeft,.topRight])
                        .shadow(radius: 7)
                    
                    
                    AsyncImage(url: URL(string: item.thumbnailPath)) {
                        $0.image?.resizable()
                    }
                    .frame(width: 152,height: 100)
                    .cornerRadius(15,corners: [.topLeft,.topRight])
                }
                ZStack{
                    Rectangle()
                        .frame(width: 152,height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                        .shadow(radius: 7)
                    
                    VStack{
                        Text(item.title)
                            .font(.system(size: 15,weight: .bold))
                            .foregroundStyle(Color.black)
                            .padding(.bottom, 3)
                            .frame(width: 140, alignment: .leading)
                        
                        Text("\(spotViewModel.distanceCalc(spot: item))km")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.red)
                            .frame(width: 140, alignment: .leading)
                        
                    }.frame(maxWidth: 152,maxHeight: 70)
                }
                
            } else {
                HStack(spacing:0){
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 210, height: 180)
                            .foregroundStyle(Color.gray)
                            .cornerRadius(15,corners: [.topLeft,.bottomLeft])
                            .shadow(radius: 7)
                        
                        AsyncImage(url: URL(string: item.thumbnailPath)) {
                            $0.image?.resizable()
                        }
                        .frame(width: 210, height: 180)
                        .cornerRadius(15,corners: [.topLeft,.bottomLeft])
                        
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: 160, height: 180)
                            .cornerRadius(15,corners: [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack{
                            Text(item.title)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.black)
                                .frame(width: 150, alignment: .leading)
                                .padding(.bottom, 5)

                            Text("\(spotViewModel.distanceCalc(spot: item))km")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.red)
                                .frame(width: 150, alignment: .leading)

                        }
                    }
                }//H
            }
        }
    }
}

#Preview {
    SpotView(spotViewModel: SpotViewModel.shared)
}
