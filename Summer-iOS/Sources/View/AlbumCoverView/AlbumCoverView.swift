//
//  ContentView.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/09/30.
//

import SwiftUI

struct AlbumCoverView: View {
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var image: Image?
    @State private var name: String = "(no name)"
    @State var tag: Int? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            // ContentView
            VStack(){
                HStack{}.frame(width: 50, height: 50)
                VStack(){
                    Text(UserDefaultsManager.getUserDefaultsObject(forKey: .albumName) as? String ?? "(no name)")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black))
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                    VStack{
                        
                        if image != nil {
                            image?
                                .resizable()
                                .scaledToFill()
                        }
                        else {
                            Spacer()
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.pointPink)
                            Spacer()
                        }
                    }
                    .frame(width: 250, height: 250)
                    .background(Color.white50)
                    .cornerRadius(0)
                    .border(Color.white, width: 10)
                }
                .padding(.top, 90)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.peachPink)
            
            // Button
            ZStack{
                NavigationLink(destination: AlbumCollectionView(), tag: 1, selection: self.$tag ) {
                    EmptyView()
                }
                CustomImageButton(isDisabled: false,
                                  imageName: "heart-empty",
                                  width: 90,
                                  height: 90){
                    self.tag = 1
                }
            }
        }
        .onAppear{
            getCoverImage()
        }
        .onChange(of: isFirstLaunching) { _ in
            getCoverImage()
        }
        .fullScreenCover(isPresented: $isFirstLaunching) {
            NavigationView {
                EditAlbumNameView(isFirstLaunching: $isFirstLaunching)
            }
        }
            
    }
    
    func getCoverImage() {
        if let imageData = UserDefaultsManager.getUserDefaultsObject(forKey: .albumCoverImage),
           let uiImage = UIImage(data: imageData as! Data) {
            self.image = Image(uiImage: uiImage)
        }
    }
}




struct AlbumCoverView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCoverView()
    }
}
