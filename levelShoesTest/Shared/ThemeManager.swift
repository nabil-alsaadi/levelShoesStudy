//
//  ThemeManager.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import Foundation
import SwiftUI

extension Color {
    public static var shadowColor =  Color.black.opacity(0.05)
    public static var tagColor =  Color(uiColor: UIColor(hex: "#f5f5f5") ?? .black )
    public static var lightGray =  Color(uiColor: UIColor(hex: "#c2c0c0") ?? .black )
}

extension Font {
    public static let h1: Font = Font.system(size: 20, weight: .regular, design: .rounded)
    public static let h2: Font = Font.system(size: 16, weight: .regular, design: .rounded)
    public static let p: Font = Font.system(size: 14, weight: .regular, design: .rounded)
    public static let small: Font = Font.system(size: 12, weight: .regular, design: .rounded)
}
