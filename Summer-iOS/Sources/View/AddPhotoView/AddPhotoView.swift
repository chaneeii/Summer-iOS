//
//  AddPhotoView.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import SwiftUI

struct AddPhotoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tag: Int? = nil
    @State var date: Date = Date()
    
    
    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var image: Image?
    @State private var imageSourceType: ImageSourceType = .library
    
    @State private var showingErrorAlert = false
    @State private var errorAlertMessage = ""
    
    
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
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .center) {
                        Text("추억을 기록해볼까요?")
                    }
                    .font(.system(size: 22, weight: .black))
                    .foregroundColor(Color.pointPink)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.bottom, 5)
                    
                    HStack{
                        Spacer()
                        
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
                            .frame(maxWidth: 313.41, maxHeight: 459.62)
                            .background(Color.white50)
                            .cornerRadius(10)
                        }
 
                        Spacer()
                    }
                    DatePicker("날짜를 골라주세요",
                               selection: $date,
                               displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding()
                        .foregroundColor(.gray41)
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
                                  imageName: "check-color",
                                  width: 90,
                                  height: 90){
                    self.tag = 1
                }
            }
            
        }
        .background(Color.babyPink)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$uiImage, sourceType: self.imageSourceType)
        }
        .alert(isPresented: $showingErrorAlert, content: {
            Alert(title: Text(errorAlertMessage))
        })
        
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

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView()
    }
}
