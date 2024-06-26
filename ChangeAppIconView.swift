//
//  ChangeAppIconView.swift
//  Bubbles
//
//  Created by Berk Dogan on 28/5/2023.
//
// All working nicely!
// Huge thanks to --> https://www.avanderlee.com/swift/alternate-app-icon-configuration-in-xcode/
// ChangeAppIcon

import SwiftUI


struct ChangeAppIconView: View {
    @StateObject var viewModel = ChangeAppIconViewModel()

    var body: some View {
        VStack {
            VStack {
                Text("Custom App Icon Picker!")
                    .font(.title.bold())
                    .padding(.bottom, 22)
                
                Text("Want to spice things up? You can change the app icon here.")
                    .font(.body)
                    .padding(.bottom, 22)
            }
            .padding(.horizontal, 30)
            
            ScrollView {
                VStack(spacing: 11) {
                    ForEach(ChangeAppIconViewModel.AppIcon.allCases) { appIcon in
                        HStack(spacing: 16) {
                            Image(uiImage: appIcon.preview)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .cornerRadius(12)
                            Text(appIcon.description)
                                .font(.body)
                            Spacer()
                            //CheckboxView(isSelected: viewModel.selectedAppIcon == appIcon)
                        }
                        .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .onTapGesture {
                            withAnimation {
                                viewModel.updateAppIcon(to: appIcon)
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 5)
                
            
            Spacer()
            
            
            }
            .padding(.bottom, 10)
        }
    } 
}





struct ChangeAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAppIconView()
    }
}
