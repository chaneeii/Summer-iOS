//
//  UserDefaultsKey.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/10/01.
//
// ref: https://sunidev.tistory.com/m/81, https://gyuios.tistory.com/101

import Foundation
import SwiftUI


class UserDefaultsManager {
    
    public enum UserDefaultsKey: String {
        case albumName
        case albumCoverImage
    }

    static func getUserDefaultsObject(forKey defaultsKey: UserDefaultsKey) -> Any? {
        let defaults = UserDefaults.standard
        if let object = defaults.object(forKey: defaultsKey.rawValue) {
            return object
        } else {
            return nil
        }
    }
    
    static func setUserDefaults(_ value: Any?, forKey defaultsKey: UserDefaultsKey) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: defaultsKey.rawValue)
    }
    

    static func setUserDefaultsWithIamge(UIImage value: UIImage?, forKey defaultsKey: UserDefaultsKey) {
        let imageData = value?.jpegData(compressionQuality: 0.2)
        UserDefaults.standard.set(imageData, forKey: defaultsKey.rawValue)
    }

}
