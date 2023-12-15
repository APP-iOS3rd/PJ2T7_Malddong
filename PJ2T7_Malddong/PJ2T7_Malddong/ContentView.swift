//
//  ContentView.swift
//  PJ2T7_Malddong
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ToiletListView()
                .tabItem {
                    Image(systemName: "house")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                }
            MyPageView()
                .tabItem {
                    Image(systemName: "heart")
                }
        }

    }
}

#Preview {
    ContentView()
}
