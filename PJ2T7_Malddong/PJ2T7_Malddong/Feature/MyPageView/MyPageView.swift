//
//  MyPageView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData

extension View {
    // Extension 에서 겹쳐서 우선 주석 처리
    
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
}

//struct RoundedCorner: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//
//        return Path(path.cgPath)
//    }
//}

struct MyPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: MyToilets.entity(), sortDescriptors: [])
    private var myToilets: FetchedResults<MyToilets>
    
    @State private var toiletsDetail = true
    @State private var parkingsDetail = false
    @State private var tourlistsDetail = false
    
    private var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    //let data =
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Text("MY PAGE")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .padding(20)
                    Spacer()
                }
                DisclosureGroup("화장실", isExpanded: $toiletsDetail) {
                    LazyVGrid(columns: gridItems, spacing: 30) {
                        ForEach(myToilets) { toilets in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(height:150)
                                    .shadow(radius: 2)
                                
                                VStack {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.yellow)
                                            .frame(maxHeight: .infinity)
                                            .cornerRadius(20, corners: [.topLeft, .topRight])
                                        HStack (alignment: .top) {
                                            Spacer()
                                            Image(systemName: "heart")
                                                .padding(4)
                                        }
                                    }
                                    Spacer()
                                    Text(toilets.toiletNm ?? "")
                                        .foregroundStyle(.secondary)
                                        .padding()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                DisclosureGroup("주차장", isExpanded: $parkingsDetail) {
                    Text("rhksdfhkadslfjflk")
                }
                .padding()
                .foregroundColor(.black)
                
                
                DisclosureGroup("관광지", isExpanded: $tourlistsDetail) {
                    Text("rhksdfhkadslfjflk")
                }
                .padding()
                .foregroundColor(.black)
                Spacer().background(Color.gray)
            }
            
        }
    }
}


#Preview {
    MyPageView()
}
//
//TabView {
//    ToiletListView()
//        .tabItem {
//            Image(systemName: "house")
//        }
//    MapView()
//        .tabItem {
//            Image(systemName: "person")
//        }
//
//    MyPageView()
//        .tabItem {
//            Image(systemName: "heart")
//        }
//}
