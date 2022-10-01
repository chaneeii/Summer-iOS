//
//  EditAlbumNameView.swift
//  Summer
//
//  Created by Chanhee Jeong on 2022/10/01.
//

import SwiftUI


struct EditAlbumNameView: View {
    
    @Binding var isFirstLaunching: Bool
    @State var albumName: String = ""
    @State var tag: Int? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            // ContentView
            VStack(alignment: .leading){
                
                HStack{}.frame(width: 50, height: 50)
                
                Text("앨범 이름을\n설정해주세요")
                    .foregroundColor(Color.pointPink)
                    .font(.system(size: 28, weight: .black))
                    .padding(.bottom, 20)
                    .padding(.top, 30)
                
                Text("앨범이름은 언제든 수정가능해요 (최대 15자)")
                    .foregroundColor(.grayC5)
                    .font(.system(size: 17, weight: .medium))
                
                
                
                VStack{
                    TextField("앨범명을 입력해주세요", text: $albumName.max(15))
                        .padding()
                        .foregroundColor(.gray41)
                }
                .frame(height: 50)
                .background(Color.white50)
                .cornerRadius(10)
                .padding(.top, 50)
                
                Spacer()
                
            }
            .padding(EdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39))
            
            
            // Button
            ZStack{
                NavigationLink(destination: EditAlbumCoverView(isFirstLaunching: $isFirstLaunching,
                                                               albumName: $albumName), tag: 1, selection: self.$tag ) {
                    EmptyView()
                }
                CustomImageButton(isDisabled: albumName.isEmpty,
                                  imageName: albumName.isEmpty ? "check-gray" : "check-color",
                                  width: 100,
                                  height: 100){
                    hideKeyboard()
                    if(!albumName.isEmpty) {
                        self.tag = 1
                    }
                }
            }
        }
        .background(Color.babyPink)
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        
        
        
    }
}


struct EditAlbumNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditAlbumNameView(isFirstLaunching: .constant(true))
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
