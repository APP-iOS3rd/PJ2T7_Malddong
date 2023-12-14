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
    @State private var searchText: String = ""
    @State private var isSearchBarvisible: Bool = false
    var filteredToiletList: [Toilet] {
        toiletListViewModel.filteredToiletList
    }

    
    
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
                            
                            // 검색 버튼
                            Button(action: {
                                withAnimation {
                                    isSearchBarvisible.toggle()
                                    
                                    if isSearchBarvisible {
                                        search()
                                    }
                                }
                                
                            }){
                                Image("search")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 28, height: 28)
                                    .clipped()
                                    .padding(12)
                            }
                        }// HStack
                        
                        
                        // TextField
                        if isSearchBarvisible {
                            HStack{
                                TextField("검색어를 입력하세요.", text: $searchText)
                                    .frame(height: 40)
                                    .transition(.move(edge: .top))
                                    .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                                
                                Button("검색"){
                                    search()
                                }.padding()
                            }
                            .background(Color.white)
                            .border(.gray, width: 2)
                            .cornerRadius(15)
                            .padding()
                            
                        }
                        
                        distributeView(
                            toiletListViewModel: toiletListViewModel)
                        .padding(.horizontal)
                        
                        
                        GridView(toiletListViewModel: toiletListViewModel)
                            .padding()
                        
                        
                    }// VStack
            }
        }
        .onAppear{
            toiletListViewModel.fectchData()
        }
    }
    private func search(){
        print("검색 시작: \(searchText)")
        
        if searchText.isEmpty {
            // 검색 내용이 없으면 리셋
            toiletListViewModel.resetFilter()
        } else {
            toiletListViewModel.filterByName(searchText)
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
            
            
        
        
        
    }
}
//MARK: - ToiletCellView
private struct ToiletCellView:View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: MyToilets.entity(), sortDescriptors: [])
    private var myToilets: FetchedResults<MyToilets>
    
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
                        .onTapGesture {
                            addItem()
                        }
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
    private func addItem() {
           withAnimation {
               //수정 부분
               let newToilet = MyToilets(context: viewContext)
               newToilet.toiletNm = item.toiletNm
               
               saveItems()
           }
       }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

        
        
        

#Preview {
    ToiletListView()
}
