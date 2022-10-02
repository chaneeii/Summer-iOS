//
//  SettingsView.swift
//  Summer-iOS
//
//  Created by Chanhee Jeong on 2022/10/02.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tag: Int? = nil
    
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
                    Text("Settings")
                        .foregroundColor(.pointPink)
                        .font(.system(size: 28, weight: .black))
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    ZStack{
                        NavigationLink(destination: EditAlbumNameView(isFirstLaunching: .constant(false)), tag: 1, selection: self.$tag ) {
                            EmptyView()
                        }
                        Button {
                            self.tag = 1
                        } label: {
                            Text("앨범 이름 수정하기")
                                .foregroundColor(Color.gray41)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.white50)
                                .cornerRadius(10)
                                .padding(.top, 10)
                        }
                    }
                    ZStack{
                        NavigationLink(destination: EditAlbumCoverView(isFirstLaunching: .constant(false), albumName: .constant("name")), tag: 2, selection: self.$tag ) {
                            EmptyView()
                        }
                        Button {
                            self.tag = 2
                        } label: {
                            Text("앨범 커버 수정하기")
                                .foregroundColor(Color.gray41)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.white50)
                                .cornerRadius(10)
                                .padding(.top, 10)
                        }
                    }

                    
                    Spacer()
                }
                .padding(EdgeInsets(top:0, leading: 39, bottom: 0, trailing: 39))

            }
            
        }
        .background(Color.babyPink)
        .navigationBarBackButtonHidden(true)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
