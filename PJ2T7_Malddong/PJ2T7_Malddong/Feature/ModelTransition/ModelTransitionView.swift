//
//  ModelTransitionView.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/13.
//

import SwiftUI

struct ModelTransitionView: View {
    @StateObject var toiletListViewModel = ToiletListViewModel.shared
    @StateObject var parkingLotViewModel = ParkingLotViewModel.shared
    @StateObject var spotViewModel = SpotViewModel.shared
    
    @State private var modelSelection: Int = 0
    @State var searchText: String = ""
    @State private var isSearchBarvisible: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    modelSelection = 0
                }) {
                    customButton2(title: "화장실", imageName: "tissue", backgroundColor: modelSelection == 0 ? .malddongYellow : .malddongGray)
                }
                
                Button(action: {
                    modelSelection = 1
                }) {
                    customButton2(title: "관광지", imageName: "dolhareubang", backgroundColor: modelSelection == 1 ? .malddongGreen : .malddongGray)
                }
                
                Button(action: {
                    modelSelection = 2
                }) {
                    customButton2(title: "주차장", imageName: "car", backgroundColor: modelSelection == 2 ? .malddongBlue : .malddongGray)
                }
                Spacer()
                
                Button(action: {
                    isSearchBarvisible.toggle()
                    
                    if isSearchBarvisible {
                    }
                }){
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipped()
                        .padding(12)
                }
            }// H
            .padding(16)
            
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
            
            switch modelSelection {
            case 0:
                ToiletListView()
            case 1:
                SpotView()
            case 2:
                ParkingLotView()
            default:
                ToiletListView()
            }
        }// V
    }
    
    private func search(){
        if(modelSelection == 0){
            toiletListViewModel.filterByName(searchText)
        }
        else if(modelSelection == 1){
            spotViewModel.filterByName(searchText)
        }
        else if(modelSelection == 2){
            parkingLotViewModel.filterByName(searchText)
        }
        
    }
}

#Preview {
    ModelTransitionView()
}
