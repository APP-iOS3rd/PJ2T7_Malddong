//
//  ModelTransitionView.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/13.
//

import SwiftUI

enum Tabs: String, CaseIterable {
    case toilet = "tissue"
    case spot = "dolhareubang"
    case parking = "car"
    
    var titleText: String {
        switch self {
        case .toilet: return "화장실"
        case .spot: return "관광지"
        case .parking: return "주차장"
        }
    }
    
    var tabColor: Color {
        switch self {
        case .toilet: return .malddongYellow
        case .spot: return .malddongGreen
        case .parking: return .malddongBlue
        }
    }
}

struct CustomTabBar: View {
    @Binding var currentTab: Tabs
    
    var body: some View {
        HStack {
            ForEach(Tabs.allCases, id: \.rawValue) { tab in
                Button {
                    currentTab = tab
                } label: {
                    customButton2(title: tab.titleText,
                                  imageName: tab.rawValue,
                                  backgroundColor: currentTab == tab ? tab.tabColor : .malddongGray)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct ContainerView: View {
    @Binding var currentTab: Tabs
    @Binding var isSearchBarvisible: Bool
    
    var body: some View {
        VStack {
            HStack {
                CustomTabBar(currentTab: $currentTab)
                
                Spacer()
                
                Button(action: {
                    isSearchBarvisible.toggle()
                    
                    if isSearchBarvisible {}
                }) {
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipped()
                        .padding(12)
                }
            }
        }
    }
}


struct ModelTransitionView: View {
    @StateObject var toiletListViewModel = ToiletListViewModel.shared
    @StateObject var spotViewModel = SpotViewModel.shared
    @StateObject var parkingLotViewModel = ParkingLotViewModel.shared
    
    @State private var currentTab: Tabs = .toilet
    
    @State private var modelSelection: Int = 0
    @State var searchText: String = ""
    @State private var isSearchBarvisible: Bool = false
    
    var body: some View {
        VStack {
            ContainerView(currentTab: $currentTab, isSearchBarvisible: $isSearchBarvisible)
                .padding(16)
            
            // TextField
            if isSearchBarvisible {
                HStack{
                    TextField("검색어를 입력하세요.", text: $searchText)
                        .frame(height: 40)
                        .transition(.move(edge: .top))
                        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                    
                    Button("검색"){ search() }
                        .padding()
                }
                .background(Color.white)
                .border(.gray, width: 2)
                .cornerRadius(15)
                .padding()
            }
            
            TabView(selection: $currentTab) {
                ToiletListView()
                    .tag(Tabs.toilet)
                
                SpotView()
                    .tag(Tabs.spot)
                
                ParkingLotView()
                    .tag(Tabs.parking)
            }
        }
    }
    
    private func search() {
        switch currentTab {
        case Tabs.toilet:
            toiletListViewModel.filterByName(searchText)
        case Tabs.spot:
            spotViewModel.filterByName(searchText)
        case Tabs.parking:
            parkingLotViewModel.filterByName(searchText)
        }
    }
}

#Preview {
    ModelTransitionView()
}
