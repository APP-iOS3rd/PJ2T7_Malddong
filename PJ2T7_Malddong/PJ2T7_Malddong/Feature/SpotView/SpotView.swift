//
//  TouristResorView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct SpotView: View {
    @StateObject private var spotViewModel = SpotViewModel(spotitem: [])
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    distributeView(
                        spotViewModel:
                            spotViewModel)
                    .padding(.horizontal)
                    
                    
                    GridView(spotViewModel:
                                spotViewModel)
                    .padding()
                }
            }
            .onAppear{
                spotViewModel.fetchData()
            }
        }
    }
}

//TODO: - distributeView/grid 패턴 변경 버튼
private struct distributeView:View{
    @ObservedObject private var spotViewModel: SpotViewModel
    
    init(spotViewModel: SpotViewModel) {
        self.spotViewModel = spotViewModel
    }
    
    var body: some View{
        HStack{
            Button(action: {
                spotViewModel.gridOneLine()
            }, label: {
                Image(systemName: "square.fill.text.grid.1x2")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            
            Button(action: {
                spotViewModel.gridTwoLine()
            }, label: {
                Image(systemName: "square.grid.2x2.fill")
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
            
            ForEach(spotViewModel.spotitem, id: \.self) { item in
                NavigationLink(destination: SpotDetailView(spot: item)){
                    SpotCellView(spotViewModel: spotViewModel, item: item)
                        .padding()
                }
            }
        })
    }
}

// SpotCellView
private struct SpotCellView:View{
    @ObservedObject private var spotViewModel:
    SpotViewModel
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
                    .onTapGesture {
                    }
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
                        
                        HStack{
                            Text(item.roadAddress)
                                .frame(width: 70)
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .foregroundStyle(Color.gray)
                            
                            Text("1.2km")
                                .foregroundStyle(Color.black)
                        }
                        
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
                            .cornerRadius(15,corners:
                                            [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack{
                            Text(item.title)
                                .font(.system(size: 20,weight: .bold))
                                .foregroundStyle(Color.black)
                                .padding(10)
                            Text("1.6km")
                                .foregroundStyle(Color.black)
                            Text(item.roadAddress)
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
    SpotView()
}
