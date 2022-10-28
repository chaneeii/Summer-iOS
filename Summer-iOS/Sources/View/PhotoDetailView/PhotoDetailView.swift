//
//  SwiftUIView.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/03.
//

import SwiftUI
import RealmSwift

struct PhotoDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    @State var fourto: Fourto
    @ObservedResults(Fourto.self) var fourtoList
    
    let localRealm = try! Realm()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading){
                
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.pointPink)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                .padding(.bottom, 50)
                
                VStack(alignment: .center){
                    HStack{
                        Spacer()
                        VStack(alignment: .center){
                            getImage(for: fourto)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 454.84)
                                .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                            
                            Text(fourto.takenDate.getDateToString(format: "YYYY/MM/dd"))
                                .foregroundColor(Color.gray77)
                                .font(.system(size: 16))
                                .padding(.top, 20)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            // Button
            CustomImageButton(isDisabled: false,
                              imageName: "x-mark",
                              width: 90,
                              height: 90){
                self.showingAlert.toggle()
            }
            
        }
        .background(Color.babyPink)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showingAlert) {
            let firstButton = Alert.Button.destructive(Text("삭제")) {
                // 삭제
                $fourtoList.remove(fourto)
                dismiss()

            }
            let secondButton = Alert.Button.cancel(Text("취소")) {
                dismiss()
            }
            return Alert(title: Text("사진 삭제"),
                         message: Text("이 사진을 삭제할까요?"),
                         primaryButton: firstButton, secondaryButton: secondButton)
        }
    }
    
    func selectById(fourtoId: String) -> Fourto? {
        let predicate = NSPredicate(format: "id == %i", fourtoId)
        return localRealm.objects(Fourto.self).filter(predicate).first
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

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
