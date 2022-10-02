//
//  AlbumCarouselView.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/02.
//

import SwiftUI
import RealmSwift

struct AlbumCarouselView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedResults(Fourto.self) var fourtoList
    @State var tag: Int? = nil
    @State var currentIndex: Int = 0 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading){
                
                HStack{

                    Spacer()
                    // Button
                    
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.pointPink)
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 20)
                    }

                }
                
                VStack(alignment: .leading){
                    
                    CustomCarousel(index: $currentIndex,
                                   items: fourtoList,
                                   cardPadding: 120,
                                   id: \.id) { fourto, cardSize in
                        // MARK: YOUR CUSTOM CELL VIEW
                        VStack{
                            getImage(for: fourto)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 454.84)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Text(fourto.takenDate.getDateToString(format: "YYYY/MM/dd"))
                                .foregroundColor(Color.gray77)
                                .font(.system(size: 16))
                                .padding(.top, 20)
                        }
                        .frame(width: cardSize.width, height: cardSize.height)

                    }
                    .padding(.top, -10)
                    Spacer()
                }
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

//struct AlbumCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumCarouselView()
//    }
//}

extension Date {
    public func getDateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        return formatter.string(from: self)
    }
}

