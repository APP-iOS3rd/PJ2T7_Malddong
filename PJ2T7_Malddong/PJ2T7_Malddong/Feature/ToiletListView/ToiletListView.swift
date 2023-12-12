//
//  ToiletListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ToiletListView: View {
    @StateObject private var toiletListViewModel = ToiletListViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                VStack{
                    distributeView(
                        toiletListViewModel: toiletListViewModel)
                    .padding(.horizontal)
                    
                    
                    GridView(toiletListViewModel: toiletListViewModel)
                        .padding()
                    
                    
                }
            }
        }
        
        
        .onAppear{
            toiletListViewModel.fectchData()
        }
    }
}

//TODO: - distributeView/grid 패턴 변경 버튼
private struct distributeView:View{
    @ObservedObject private var toiletListViewModel: ToiletListViewModel
    
    
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View{
        
        
        HStack{
            Button(action: {
                toiletListViewModel.gridOneLine()
            }, label: {
                Image(systemName: "square.fill.text.grid.1x2")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            Button(action: {
                toiletListViewModel.gridTwoLine()
            }, label: {
                Image(systemName: "square.grid.2x2.fill")
                    .font(.system(size: 25))
                    .foregroundStyle(Color.black)
            })
            Spacer()
            Picker("", selection:$toiletListViewModel.distributeSelect
                    , content: {
                ForEach(toiletListViewModel.distributeArea,id: \.self){item in
                    Text(item)
                    
                }
            })
        }
    }
       
    
}

//MARK: - GrideView
private struct GridView:View {
    @ObservedObject private var toiletListViewModel: ToiletListViewModel
    @State var item:Toilet = Toilet(dataCd: "", laCrdnt: "", loCrdnt: "", rnAdres: "", toiletNm: "", opnTimeInfo: "", mngrInsttNm: "", telno: "", maleClosetCnt: "", maleUrinalCnt: "", maleDspsnClosetCnt: "", maleDspsnUrinalCnt: "", maleChildClosetCnt: "", maleChildUrinalCnt: "", femaleClosetCnt: "", femaleChildClosetCnt: "", femaleDspsnClosetCnt: "")
    @State var pop = false
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View {
        
            LazyVGrid(columns: toiletListViewModel.isGridAlign ? [
                GridItem(.flexible()),
                GridItem(.flexible()),] :[GridItem(.flexible())]
                      , content: {
                ForEach(toiletListViewModel.toiletList,id: \.self){item in
                    NavigationLink(destination: ToiletDetailView(item: item,toiletListViewModel: toiletListViewModel)) {
                        
                        ToiletCellView(toiletListViewModel: toiletListViewModel, item:  item)
                            .padding()
                    }
                        
                    
                    
                }//FE
                
                
            })
            
            
        
        .animation(.default)
        
    }
}
//MARK: - ToiletCellView
private struct ToiletCellView:View{
    @ObservedObject private var toiletListViewModel:ToiletListViewModel
    private var item:Toilet
    
    init(toiletListViewModel: ToiletListViewModel, item: Toilet) {
        self.toiletListViewModel = toiletListViewModel
        self.item = item
    }
    
    var body: some View{
        VStack(spacing:0){
            if toiletListViewModel.isGridAlign{
                ZStack{
                    
                    
                    Rectangle()
                        .frame(width: 152,height: 100)
                        .foregroundColor(.gray)
                        .cornerRadius(15,corners: [.topLeft,.topRight])
                        .shadow(radius: 7)
                    
                    AsyncImage(url: URL(string:
                                            toiletListViewModel.imageNilCheck(item)
                                       )){
                        $0.image?.resizable()
                    }
                        
                        .scaledToFit()
                        .frame(maxWidth: 152,maxHeight: 100)
                }
                ZStack{
                    Rectangle()
                        .frame(width: 152,height: 70)
                        .foregroundColor(.white)
                        .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                        .shadow(radius: 7)
                    
                    VStack{
                        Text(item.toiletNm)
                            .font(.system(size: 15,weight: .bold))
                        
                        HStack{
                            Text(item.rnAdres)
                                .frame(width: 70)
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .foregroundStyle(Color.gray)
                            
                            Text("\(toiletListViewModel.distanceCalc(toilet: item))km")
                            //15592
                        }
                        
                    }.frame(maxWidth: 152,maxHeight: 70)
                }
            }else{
                HStack(spacing:0){
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 210, height: 180)
                            .foregroundStyle(Color.gray)
                            .cornerRadius(15,corners: [.topLeft,.bottomLeft])
                            .shadow(radius: 7)
                        AsyncImage(url: URL(string:
                                                toiletListViewModel.imageNilCheck(item)
                                           )){
                            $0.image?.resizable()
                        }
                            .scaledToFit()
                            .frame(maxWidth: 210,maxHeight: 180)
                            
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: 160, height: 180)
                            .cornerRadius(15,corners:
                                            [.topRight,.bottomRight])
                            .foregroundStyle(Color.white)
                            .shadow(radius: 7)
                        
                        VStack{
                            Text(item.toiletNm)
                                .font(.system(size: 20,weight: .bold))
                            Text("1.6km")
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
    ToiletListView()
}
