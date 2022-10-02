//
//  Fourtos.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/02.
//

import Foundation
import RealmSwift

public class Fourtos: FourtosProtocol {
    
    @Published private(set) var all = [Fourto]()
    
    init() {
        loadSavedData()
    }

    func add(photo: Fourto) {
        guard write(photo: photo) else { return }

        all.append(photo)
        
    }
    
    private func write(photo: Fourto) -> Bool {
        realmWrite { realm in
            realm.add(photo, update: .modified)
        }
    }
    
    private func realmWrite(operation: (_ realm: Realm) -> Void) -> Bool {
        guard let realm = getRealm() else { return false }
        
        // realm 파일위치
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        do {
            try realm.write { operation(realm) }
        }
        catch let error as NSError {
            print(error.localizedDescription)
            return false
        }

        return true
    }
    
    private func getRealm() -> Realm? {
        do {
            return try Realm()
        }
        catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func loadSavedData() {
        DispatchQueue.global().async {
            guard let realm = self.getRealm() else { return }

            let objects = realm.objects(Fourto.self).sorted(byKeyPath: "date", ascending: true)

            let fourtos: [Fourto] = objects.map { object in
                self.buildFourto(fourto: object)
            }
            
            DispatchQueue.main.async {
                self.all = fourtos
            }
        }
    }
    
    private func buildFourto(fourto: Fourto) -> Fourto {
        guard let id = UUID(uuidString: fourto.id) else {
            fatalError("Corrupted ID: \(fourto.id)")
        }

        let fourto = Fourto(takenDate: fourto.takenDate,
                            imagePath: fourto.imagePath ?? "")

        return fourto
    }
    
    
}
