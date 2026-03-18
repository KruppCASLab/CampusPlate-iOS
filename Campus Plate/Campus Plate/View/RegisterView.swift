//
//  RegisterView.swift
//  Campus Plate
//
//  Created by Brian Krupp on 2/4/26.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack {
            Image("Background-Texture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame(.horizontal) {
                    width, axis in
                    return width
                }
                
            VStack {
                Image("Header-Image-White")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                HStack {
                    Spacer(minLength: 60)
                    VStack(spacing:20) {
                        HStack {
                            Text("University Email")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .keyboardType(.emailAddress)
                            Spacer()
                        }
                        TextField("", text: $email)
                            .background(.white)
                            .font(.title2)
                        Button("Get Pin") {
                            isShowingSheet.toggle()
                            // TODO: Task to call service
                        }
                        .foregroundStyle(.accent)
                        .font(.title3)
                        .buttonStyle(.borderedProminent)
                        .tint(.white)
                        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                            PinConfirmationView()
                        }
                        
                    }.padding()
                    Spacer(minLength: 60)
                }
            }
            .padding()
        }
        .background(.tint)
    }
    
    func didDismiss() {
        // Handle dismissed sheet
    }
}

#Preview {
    RegisterView()
}
