//
//  ToiletListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData

struct ToiletListView: View {
    @StateObject private var toiletListViewModel = ToiletListViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                VStack{
                    HStack {
                        NavigationLink(destination: ToiletListView()) {
                           
                            customButton2(title: "화장실", imageName: "tissue", backgroundColor: .malddongYellow)
                        }
                        NavigationLink(destination: SpotView()){
                            
                            customButton2(title: "관광지", imageName: "dolhareubang", backgroundColor: .malddongGreen)
                                
                            
                        }
                        NavigationLink(destination: ParkingLotView()){
                            customButton2(title: "주차장", imageName: "car", backgroundColor: .malddongBlue)
                        }
                        
                        Spacer()
                        
                        Image("search")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28)
                            .clipped()
                    }
                    .padding(12)
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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: MyToilets.entity(), sortDescriptors: [])
    private var myToilets: FetchedResults<MyToilets>
    
    @ObservedObject private var toiletListViewModel: ToiletListViewModel
    
    
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View {
        
            LazyVGrid(columns: toiletListViewModel.isGridAlign ? [
                GridItem(.flexible()),
                GridItem(.flexible()),] :[GridItem(.flexible())]
                      , content: {
                ForEach(toiletListViewModel.toiletList,id: \.self){item in
                    ZStack {
                        NavigationLink(destination: ToiletDetailView(item: item,toiletListViewModel: toiletListViewModel)) {
                            
                            ToiletCellView(toiletListViewModel: toiletListViewModel, item:  item)
                                .padding()
                        }
                        HStack {
                            Spacer()
                            LikeButton(myToilets: myToilets, item: item) {
                                if let toilet =  myToilets.first(where: { $0.toiletNm == item.toiletNm }) {
                                    print("\(toilet.isLiked)")
                                    toilet.isLiked.toggle()
                                } else {
                                    DataController().addItem(photo: item.photo, telno: item.telno, rnAdres: item.rnAdres, toiletNm: item.toiletNm, isLiked: true, laCrdnt: item.laCrdnt, loCrdnt: item.loCrdnt ,context: viewContext)
                                }
                            }
                        }
                    }  
                }//FE
            })
            
            
        
        
        
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
                            .foregroundStyle(Color.black)
                        
                        HStack{
                            Text(item.rnAdres)
                                .frame(width: 70)
                                .font(.system(size: 10))
                                .lineLimit(2)
                                .foregroundStyle(Color.gray)
                            
                            Text("\(toiletListViewModel.distanceCalc(toilet: item))km")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.gray)
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
                                .foregroundStyle(Color.black)
                            Text("\(toiletListViewModel.distanceCalc(toilet: item))km")
                                .foregroundStyle(Color.black)
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
