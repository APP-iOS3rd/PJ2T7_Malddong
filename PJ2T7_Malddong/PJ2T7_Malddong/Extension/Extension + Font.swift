//
//  Extension + Font.swift
//  PJ2T7_Malddong
//
//  Created by 이종원 on 12/11/23.
//

import UIKit
import Foundation

extension UIFont {
    static func LINESeedKR(size fontsize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "LINESeedKR"
        
        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bd"
        case .regular:
            weightString = "Rg"
        case .thin:
            weightString = "Th"
        default:
            weightString = "Rg"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: fontsize) ?? .systemFont(ofSize: fontsize, weight: weight)
    }
}
