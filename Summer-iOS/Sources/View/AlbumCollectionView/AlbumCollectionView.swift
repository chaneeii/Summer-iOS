//
//  AlbumCollectionView.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import SwiftUI
import RealmSwift

struct AlbumCollectionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedResults(Fourto.self) var fourtoList
    @State var tag: Int? = nil
    
    private var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading){
                
                HStack{
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.pointPink)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 20)
                    }
                    Spacer()
                    
                    // Button
                    ZStack{
                        NavigationLink(destination: SettingsView(), tag: 2, selection: self.$tag ) {
                            EmptyView()
                        }
                        Button {
                            self.tag = 2
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 25))
                                .foregroundColor(.pointPink)
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 20)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading){
                    Text(UserDefaultsManager.getUserDefaultsObject(forKey: .albumName) as? String ?? "(no name)")
                        .foregroundColor(.pointPink)
                        .font(.system(size: 28, weight: .black))
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                    
                    VStack {
                        if fourtoList.isEmpty {
                            Text("하트 버튼을 눌러\n추억들을 쌓아가세요")
                        } else {
                            Text("📸\(fourtoList.count) photos")
                        }
                    }
                    .foregroundColor(Color.gray41)
                    .frame(maxWidth: .infinity, maxHeight: 95)
                    .background(Color.white50)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    
                    ScrollView(showsIndicators: false){
                        LazyVGrid(columns: flexibleLayout, spacing: 20) {
                            ForEach(fourtoList, id: \.id) { fourto in
                                 HStack{
                                     getImage(for: fourto)
                                         .resizable()
                                         .frame(width: 149.83, height: 227.16)
                                         .scaledToFill()
                                 }
                                 .frame(width: 149.83, height: 227.16)
                                 .background(Color.white50)
                                     
                             }
                        }
                    }
                    .padding(.top, 10)
                     
                    Spacer()
                    
                }
                .padding(EdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39))
            }
            
            // Button
            ZStack{
                NavigationLink(destination: AddPhotoView(), tag: 1, selection: self.$tag ) {
                    EmptyView()
                }
                CustomImageButton(isDisabled: false,
                                  imageName: "heart-fill",
                                  width: 90,
                                  height: 90){
                    self.tag = 1
                }
            }
            
        }
        .background(Color.babyPink)
        .navigationBarBackButtonHidden(true)

    }
    
    func getImage(for fourto: Fourto) -> Image {
        if let imageData = fourto.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
    
}

//struct AlbumCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumCollectionView()
//    }
//}
