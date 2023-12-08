//
//  TouristResorView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

struct SpotView: View {
    
    @StateObject var network = SpotViewModel.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.touristItem, id: \.self) { result in
                    HStack {
                        AsyncImage(url: URL(string: result.thumbnailPath )) {
                            image in
                            image.image?.resizable()
                        }
                        Text(result.title)
                            .bold()
                    }
                    .padding(5)
                }
            }.navigationTitle("News")
            
        }
        .onAppear() {
            network.fetchData()
        }
    }
}

#Preview {
    SpotView()
}
