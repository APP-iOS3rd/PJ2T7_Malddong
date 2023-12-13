//
//  CustomButton.swift
//  PJ2T7_Malddong
//
//  Created by 정다산 on 12/12/23.
//
import SwiftUI

public struct customButton2: View {
    let title: String
    let imageName: String
    let backgroundColor: Color
    
    public init(
        title: String,
        imageName: String,
        backgroundColor: Color
    ) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 36)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
                HStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipped()
                    
                    Text(title)
                        .foregroundStyle(.white)
                        .font(
                            Font(UIFont.LINESeedKR(size: 12, weight: .bold)))
                }
            
        }
    }
}
