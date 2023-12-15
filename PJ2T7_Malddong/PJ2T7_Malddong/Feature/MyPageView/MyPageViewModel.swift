//
//  MyPageViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreLocation

class MyPageViewModel {
    
}


struct LikeButton: View {
    var myToilets: FetchedResults<MyToilets>
    var item: Toilet
    var buttonAction: () -> Void
    @State var labelName = "heart"
    
    var body: some View {
        Button {
           buttonAction()
        } label: {
            Image(systemName: labelName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundStyle(labelName == "heart.fill" ? .red : .white)
        }
        .tint(.black)
        .padding(25)
        .onAppear {
            if let toilet =  myToilets.first(where: { $0.toiletNm == item.toiletNm }) {
                if toilet.isLiked {
                    labelName = "heart.fill"
                } else {
                    labelName = "heart"
                }
            }
        }
    }
}

struct LikeButton2: View {
    var myParkings: FetchedResults<MyParkings>
    var item: Parking
    var buttonAction: () -> Void
    @State var labelName = "heart"
    
    var body: some View {
        Button {
           buttonAction()
        } label: {
            Image(systemName: labelName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundStyle(labelName == "heart.fill" ? .red : .white)
        }
        .tint(.black)
        .padding(25)
        .onAppear {
            if let parking =  myParkings.first(where: { $0.name == item.name }) {
                if parking.isLiked {
                    labelName = "heart.fill"
                } else {
                    labelName = "heart"
                }
            }
        }
    }
}

struct LikeButton3: View {
    var mySpots: FetchedResults<MySpots>
    var item: Spot
    var buttonAction: () -> Void
    @State var labelName = "heart"
    
    var body: some View {
        Button {
           buttonAction()
        } label: {
            Image(systemName: labelName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundStyle(labelName == "heart.fill" ? .red : .white)
        }
        .tint(.black)
        .padding(25)
        .onAppear {
            if let spot =  mySpots.first(where: { $0.title == item.title }) {
                if spot.isLiked {
                    labelName = "heart.fill"
                } else {
                    labelName = "heart"
                }
            }
        }
    }
}
