//
//  FourtoProtocol.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/02.
//

import Foundation

protocol FourtosProtocol: ObservableObject {

    var all: [Fourto] { get }

    func add(photo: Fourto)

}
