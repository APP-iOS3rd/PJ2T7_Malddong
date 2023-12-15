//
//  MyPageView.swift
//  BasicSetting
//
//  Created by 정다산 on 12/5/23.
//

import SwiftUI
import CoreData
import CoreLocation

struct MyPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: MyToilets.entity(), sortDescriptors: [])
    private var myToilets: FetchedResults<MyToilets>
    
    @FetchRequest(entity: MyParkings.entity(), sortDescriptors: [])
    private var myParkings: FetchedResults<MyParkings>
    
    @FetchRequest(entity: MySpots.entity(), sortDescriptors: [])
    private var mySpots: FetchedResults<MySpots>
    
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
                    LazyVGrid(columns: gridItems, spacing: 5) {
                        ForEach(myToilets) { toilets in
                            if toilets.isLiked {
                                VStack(spacing: 0) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 100)
                                            .foregroundColor(.gray)
                                            .cornerRadius(15,corners: [.topLeft,.topRight])
                                            .shadow(radius: 7)
                                        AsyncImage(url: URL(string: toilets.photo?[0] ?? "")) {
                                            $0.image?.resizable()
                                        }
                                            .scaledToFit()
                                            .frame(width: 152, height: 100)
                                            
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image(systemName: toilets.isLiked ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .foregroundStyle(toilets.isLiked ? Color.red : Color.white)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25)
                                                    .padding(3)
                                                    .onTapGesture {
                                                        toilets.isLiked.toggle()
                                                    }
                                            }
                                        }
                                    }
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 70)
                                            .foregroundColor(.white)
                                            .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                                            .shadow(radius: 7)
                                        
                                        VStack {
                                            Text(toilets.toiletNm!)
                                                .font(.system(size: 15,weight: .bold))
                                                .foregroundStyle(Color.black)
                                            
                                            HStack{
                                                Text(toilets.rnAdres!)
                                                    .frame(width: 70)
                                                    .font(.system(size: 10))
                                                    .lineLimit(2)
                                                    .foregroundStyle(Color.gray)
                                                
                                                Text("\(mydistanceCalc(lo: toilets.loCrdnt!, la: toilets.laCrdnt!))km")
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(Color.gray)
                                                //15592
                                            }
                                        }.frame(maxWidth: 152,maxHeight: 70)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                DisclosureGroup("주차장", isExpanded: $parkingsDetail) {
                    LazyVGrid(columns: gridItems, spacing: 5) {
                        ForEach(myParkings) { parkings in
                            if parkings.isLiked {
                                VStack(spacing: 0) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 100)
                                            .foregroundColor(.gray)
                                            .cornerRadius(15,corners: [.topLeft,.topRight])
                                            .shadow(radius: 7)
    
                                            
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image(systemName: parkings.isLiked ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .foregroundStyle(parkings.isLiked ? Color.red : Color.white)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25)
                                                    .padding(3)
                                                    .onTapGesture {
                                                        parkings.isLiked.toggle()
                                                    }
                                            }
                                        }
                                    }
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 70)
                                            .foregroundColor(.white)
                                            .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                                            .shadow(radius: 7)
                                        
                                        VStack {
                                            Text(parkings.name!)
                                                .font(.system(size: 15,weight: .bold))
                                                .foregroundStyle(Color.black)
                                            
                                            HStack{
                                                Text(parkings.rnAdres!)
                                                    .frame(width: 70)
                                                    .font(.system(size: 10))
                                                    .lineLimit(2)
                                                    .foregroundStyle(Color.gray)
                                                
                                                Text("\(mydistanceCalc(lo: parkings.longitude!, la: parkings.latitude!))km")
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(Color.gray)
                                                //15592
                                            }
                                        }.frame(maxWidth: 152,maxHeight: 70)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .foregroundColor(.black)
                
                
                DisclosureGroup("관광지", isExpanded: $tourlistsDetail) {
                    LazyVGrid(columns: gridItems, spacing: 5) {
                        ForEach(mySpots) { spots in
                            if spots.isLiked {
                                VStack(spacing: 0) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 100)
                                            .foregroundColor(.gray)
                                            .cornerRadius(15,corners: [.topLeft,.topRight])
                                            .shadow(radius: 7)
                                        AsyncImage(url: URL(string: spots.thumbnailPath ?? "")) {
                                            $0.image?.resizable()
                                        }
                                            .scaledToFit()
                                            .frame(width: 152, height: 100)
                                            
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Image(systemName: spots.isLiked ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .foregroundStyle(spots.isLiked ? Color.red : Color.white)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25)
                                                    .padding(3)
                                                    .onTapGesture {
                                                        spots.isLiked.toggle()
                                                    }
                                            }
                                        }
                                    }
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 152,height: 70)
                                            .foregroundColor(.white)
                                            .cornerRadius(15,corners: [.bottomLeft,.bottomRight])
                                            .shadow(radius: 7)
//                                        
                                        VStack {
                                            Text(spots.title!)
                                                .font(.system(size: 15,weight: .bold))
                                                .foregroundStyle(Color.black)
//                                            
                                            HStack{
                                                Text(spots.roadAddress!)
                                                    .frame(width: 70)
                                                    .font(.system(size: 10))
                                                    .lineLimit(2)
                                                    .foregroundStyle(Color.gray)
//                                                
                                                Text("\(mydistanceCalc(lo: String(spots.longitude), la: String(spots.latitude)))km")
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(Color.gray)
//                                                //15592
                                            }
                                        }.frame(maxWidth: 152,maxHeight: 70)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding()
                .foregroundColor(.black)
                Spacer().background(Color.gray)
            }
            
        }
    }
    func mydistanceCalc(lo: String, la: String)->String{
        //내위치 임의 설정
        let myLocation = CLLocation(latitude: 33.44980872, longitude: 126.6182481)
        
        let objectLoaction = CLLocation(latitude: Double(la)!, longitude: Double(lo)!)
        
        let distanceMetor = myLocation.distance(from: objectLoaction)
        
        return String(Int(distanceMetor)/1000)
    }
    
}

//
//#Preview {
//    MyPageView(myPageViewModel: MyPageViewModel)
//}
