//
//  ModelTransitionView.swift
//  PJ2T7_Malddong
//
//  Created by 김재완 on 2023/12/13.
//

import SwiftUI

struct ModelTransitionView: View {
    @State private var modelSelection: Int = 0

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
                
                Image("search")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                    .clipped()
            }
            .padding(16)

            switch modelSelection {
            case 0:
                ToiletListView()
            case 1:
                ParkingLotView()
            case 2:
                SpotView()
            default:
                ToiletListView()
            }
        }
    }
}

#Preview {
    ModelTransitionView()
}
