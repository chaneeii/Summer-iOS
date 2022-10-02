//
//  EditAlbumCoverView.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import SwiftUI

struct EditAlbumCoverView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isFirstLaunching: Bool
    @Binding var albumName: String
    
    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var image: Image?
    @State private var imageSourceType: ImageSourceType = .library
    
    @State private var showingErrorAlert = false
    @State private var errorAlertMessage = ""
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack(alignment: .leading){
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .foregroundColor(.pointPink)
                        .frame(width: 50, height: 50)
                        .padding(.leading, 20)
                }
                
                VStack(alignment: .leading){
                    Text("앨범 커버를\n설정해주세요")
                        .foregroundColor(.pointPink)
                        .font(.system(size: 28, weight: .black))
                        .padding(.bottom, 20)
                        .padding(.top, 30)
                    
                    Text("커버사진은 언제든 수정가능해요")
                        .foregroundColor(.grayC5)
                        .font(.system(size: 17, weight: .medium))

                    Button {
                        selectPhoto()
                    } label: {
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
                        .frame(width: 315, height: 315)
                        .background(Color.white50)
                        .cornerRadius(10)
                    }
                    .padding(.top, 50)
                    

                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39))
            }
            
            CustomImageButton(isDisabled: image == nil,
                              imageName: image == nil ? "check-gray" : "check-color",
                              width: 90,
                              height: 90){
                
                if isFirstLaunching {
                    UserDefaultsManager.setUserDefaults(albumName, forKey: .albumName)
                    UserDefaultsManager.setUserDefaultsWithIamge(UIImage: uiImage, forKey: .albumCoverImage)
                    isFirstLaunching.toggle()
                } else {
                    UserDefaultsManager.setUserDefaultsWithIamge(UIImage: uiImage, forKey: .albumCoverImage)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.babyPink)
        .onAppear{
            if !isFirstLaunching {
                getCoverImage()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$uiImage, sourceType: self.imageSourceType)
        }
        .alert(isPresented: $showingErrorAlert, content: {
            Alert(title: Text(errorAlertMessage))
        })
        
    }
    
    func getCoverImage() {
        if let imageData = UserDefaultsManager.getUserDefaultsObject(forKey: .albumCoverImage),
           let uiImage = UIImage(data: imageData as! Data) {
            self.image = Image(uiImage: uiImage)
        }
    }
    
    func loadImage() {
        guard let uiImage = self.uiImage else { return }
        self.image = Image(uiImage: uiImage)
    }
    
    func takePicture() {
        if ImagePicker.isCameraAvailable() {
            self.imageSourceType = .camera
            self.showingImagePicker = true
        }
        else {
            self.errorAlertMessage = "Camera is not available"
            self.showingErrorAlert = true
        }
    }

    func selectPhoto() {
        self.imageSourceType = .library
        self.showingImagePicker = true
    }
    
    
}

//struct EditAlbumCoverView_Previews: PreviewProvider {
//    static var previews: some View {
////        EditAlbumCoverView(isFirstLaunching: <#T##Binding<Bool>#>)
//    }
//}
