//
//  ContentView.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/09/30.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var image: Image?
    @State private var name: String = "앨범이름이 없어요"
    
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            if image != nil {
                image?.resizable().scaledToFit()
            }
            
            Text(UserDefaultsManager.getUserDefaultsObject(forKey: .albumName) as? String ?? "")
            
        }
        .padding()
        .fullScreenCover(isPresented: $isFirstLaunching) {
            NavigationView {
                EditAlbumNameView(isFirstLaunching: $isFirstLaunching)
            }
        }
        .onAppear{
            if let imageData = UserDefaultsManager.getUserDefaultsObject(forKey: .albumCoverImage),
               let uiImage = UIImage(data: imageData as! Data) {
                self.image = Image(uiImage: uiImage)
            }
        }
        .onChange(of: isFirstLaunching) { newValue in
            if let imageData = UserDefaultsManager.getUserDefaultsObject(forKey: .albumCoverImage),
               let uiImage = UIImage(data: imageData as! Data) {
                self.image = Image(uiImage: uiImage)
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
