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
        ScrollView{
            VStack{
                distributeView(toiletListViewModel: toiletListViewModel)
                GridView(toiletListViewModel: toiletListViewModel)
                    .padding()
                    
            }
        }
    }
}
//TODO: - distributeView
private struct distributeView:View{
    @ObservedObject private var toiletListViewModel: ToiletListViewModel
    
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View{
        Text("")
    }
    
}
//MARK: - GrideView
private struct GridView:View {
    @ObservedObject private var toiletListViewModel: ToiletListViewModel
    
    init(toiletListViewModel: ToiletListViewModel) {
        self.toiletListViewModel = toiletListViewModel
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], content: {
            ForEach(toiletListViewModel.toiletList,id: \.self){item in
                ToiletCellView(item: item)
                    .padding()
                    .shadow(radius: 7)
                
            }
            
        })
        
    }
}
//MARK: - ToiletCellView
private struct ToiletCellView:View{
    private var item:Toilet
    
    init(item: Toilet) {
        self.item = item
    }
    
    var body: some View{
        VStack(spacing:0){
            ZStack{
                Rectangle()
                    .frame(width: 152,height: 100)
                    .foregroundColor(.gray)
                    .cornerRadius(15,corners: [.topLeft,.topRight])
                Image(item.toiletImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 152,maxHeight: 100)
            }
            ZStack{
                Rectangle()
                    .frame(width: 152,height: 70)
                    .foregroundColor(.white)
                    .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                VStack{
                    Text(item.toiletName)
                        .font(.system(size: 18,weight: .bold))
                    HStack{
                        Text(item.toiletAddress)
                            .frame(width: 70)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .foregroundStyle(Color.gray)
                        Text(item.toiletDistance)
                    }
                    
                }.frame(maxWidth: 152,maxHeight: 70)
            }
                
        }
        
    }
}
private struct ToiletCellInformationView:View {
    private var item:Toilet
    
    init(item: Toilet) {
        self.item = item
    }
    
    var body: some View {
        VStack{
            Text(item.toiletName)
                .font(.system(size: 18,weight: .bold))
            Text(item.toiletDistance)
            Text(item.toiletAddress)
                .font(.system(size: 13))
                .foregroundStyle(Color.gray)
                
                    
                    
            
        }
    }
}
        
        
        

#Preview {
    ToiletListView()
}
