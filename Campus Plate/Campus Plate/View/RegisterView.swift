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
    @State private var isShowingAlert = false
    @State private var isRegistering = false
    
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
                Spacer()
                VStack(spacing:30) {
                    Image("Header-Image-White")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text("University Email")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .keyboardType(.emailAddress)
                    
                    TextField("Enter Email", text: $email)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                    Button("Register") {
                        isRegistering = true
                        do {
                            try Session.shared.configure(email: email)
                            Task {
                                do {
                                    try await UserModel.createUser(username: email)
                                }
                                catch {
                                    
                                }
                                isRegistering = false
                            }
                        }
                        catch {
                            isRegistering = false
                            isShowingAlert.toggle()
                        }
                
//                            isShowingSheet.toggle()
                        // TODO: Task to call service
                    }
                    .disabled(email.isEmpty || !email.contains("@") || isRegistering)
                    .foregroundStyle(.accent)
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                        PinConfirmationView()
                    }
                    .alert("Error", isPresented: $isShowingAlert) {
                    } message: {
                        Text("The email you entered is currently not configured for Campus Plate. Please make sure you are using an email that is associated with the university.")
                    }
                    
                }
                Spacer()
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
    RegisterView(email: "krupp@case.edu")
}
