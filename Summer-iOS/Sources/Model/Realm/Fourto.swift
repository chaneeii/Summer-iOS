//
//  Fourto.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/02.
//

import Foundation
import RealmSwift

class Fourto: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var takenDate: Date
    @Persisted var imagePath: String? = nil

    convenience init(takenDate: Date,
                     imagePath: String) {
        self.init()
        
        self.takenDate = takenDate
        self.imagePath = imagePath
    }
    
    func setImage(image: Data) {
        imagePath = ImageUtils().setImage(image: image)
    }
    
    func getImage() -> Data? {
        return ImageUtils().getImage(imagePath: imagePath)
    }
    
    func deleteImage() {
        ImageUtils().deleteImage(imagePath: imagePath)
        imagePath = nil
    }
}


//extension Fourto: Equatable {
//    static func ==(lhs: Fourto, rhs: Fourto) -> Bool {
//        lhs.id == rhs.id
//    }
//}
