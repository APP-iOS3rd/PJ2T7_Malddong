//
//  MyPageViewModel.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI

class MyPageViewModel{
    
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
        }
        .tint(.black)
        .padding(10)
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

struct FilterScope: Equatable {
    var filter: String?
    var predicate: NSPredicate? {
        guard let filter = filter else { return nil }
        return NSPredicate(format: "toiletNm == %@", filter)
    }
}
