//
//  ToiletListView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData


struct ToiletListView: View {

    @StateObject var toiletListViewModel = ToiletListViewModel.shared
    var filteredToiletList: [Toilet] {
        toiletListViewModel.filteredToiletList
    }
  
    var body: some View {
        
        NavigationStack{
            distributeView(
                toiletListViewModel: toiletListViewModel)
            .padding(.horizontal)
            ScrollView{
                VStack{
                    
                    distributeView(
                        toiletListViewModel: toiletListViewModel)
                    .padding(.horizontal)
                       
                    GridView(toiletListViewModel: toiletListViewModel)
                        .padding()
                }
            }
            
            .onAppear {
                toiletListViewModel.fetchData()
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
    
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View {
        LazyVGrid(columns: toiletListViewModel.isGridAlign ? [
            GridItem(.flexible()),
            GridItem(.flexible()),] :[GridItem(.flexible())]
                  , content: {
            ForEach(toiletListViewModel.toiletList,id: \.self){item in
                
                if toiletListViewModel.distributeSelect == "전체"{
                    
                        NavigationLink(destination: ToiletDetailView(item: item,toiletListViewModel: toiletListViewModel)) {
                            
                            ToiletCellView(toiletListViewModel: toiletListViewModel, item:  item)
                                .padding()
                        }
                    }else if item.lnmAdres.contains(toiletListViewModel.distributeSelect){
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
                                       .frame(width: 152,height: 100)
                                       .cornerRadius(15,corners: [.topLeft,.topRight])
                                       .onTapGesture {
                                           //                            addItem()
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
                            Text(item.lnmAdres)
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
                        
                        AsyncImage(url: URL(string: toiletListViewModel.imageNilCheck(item))) {
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
                            Text(item.toiletNm)
                                .font(.system(size: 20,weight: .bold))
                                .foregroundStyle(Color.black)
                                .padding(10)
                            Text("\(toiletListViewModel.distanceCalc(toilet: item))km")
                                .foregroundStyle(Color.black)
                            Text(item.lnmAdres)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.gray)
                        }
                    }
                }//H
            }
        }
    }
    //    private func addItem() {
    //           withAnimation {
    //               //수정 부분
    //               let newToilet = MyToilets(context: viewContext)
    //               newToilet.toiletNm = item.toiletNm
    //               
    //               saveItems()
    //           }
    //       }
    
    //    private func saveItems() {
    //        do {
    //            try viewContext.save()
    //        } catch {
    //            // Replace this implementation with code to handle the error appropriately.
    //            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //            let nsError = error as NSError
    //            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            print("error")
    //        }
    //    }
}

#Preview {
    ToiletListView()
}
