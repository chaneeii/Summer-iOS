//
//  Color+.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import SwiftUI

extension Color {
    
    init(hex: String){
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
        
    }
    
    static let pointPink = Color(hex: "#FF6C6C") // 찐핑
    static let peachPink = Color(hex: "#FFA7A7") // 중핑
    static let babyPink = Color(hex: "#FFF9F9") // 연핑
    static let white50 = Color(hex: "#FFFFFF").opacity(0.5) // 투명화이트
    static let gray41 = Color(hex: "#414141")
    static let grayC5 = Color(hex: "#c5c5c5")
    static let gray77 = Color(hex: "#777777")
    
}
