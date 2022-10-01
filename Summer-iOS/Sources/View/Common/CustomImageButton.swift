//
//  CommonSample.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import Foundation
import SwiftUI

struct CustomImageButton: View {

    private var isDisabled: Bool = true
    private let imageName: String
    private let width: CGFloat
    private let height: CGFloat
    private let action: () -> Void

    init(isDisabled: Bool,
         imageName: String,
         width: CGFloat,
         height: CGFloat,
         action: @escaping () -> Void) {
        self.isDisabled = isDisabled
        self.imageName = imageName
        self.width = width
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
        }
        .disabled(isDisabled)
        .buttonStyle(.borderless)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
        .padding()
    }
}

