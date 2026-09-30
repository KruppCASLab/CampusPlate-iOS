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
    @Binding var isShowingRegistration:Bool
    
    @State private var path = [String]()
    
    var body: some View {
        NavigationStack(path:$path) {
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
                            .cpTextField()
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        VStack {
                            Button("Register") {
                                isRegistering = true
                                do {
                                    try Session.shared.configure(credential: Credential(username: email, password: ""))
                                    Task {
                                        do {
                                            let response = try await UserModel.createUser(username: email)
                                            
                                            if (response.status == .success || response.status == .successAccountExists) {
                                                print("Received Credential \(response.data?.credential)")
//                                                isShowingSheet = true
                                                path = ["confirm"]
                                            }
                                            
                                        }
                                        catch {
                                            print(error)
                                        }
                                        isRegistering = false
                                    }
                                }
                                catch {
                                    isRegistering = false
                                    isShowingAlert.toggle()
                                }
                            }
                            .disabled(email.isEmpty || !email.contains("@") || isRegistering)
                            .buttonStyle(CPButtonStyle())
                            
                            if isRegistering {
                                withAnimation {
                                    ProgressView()
                                }
                            }
                        }
                        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                            PinConfirmationView(username: email, isPresented: $isShowingRegistration)
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
            .navigationDestination(for: String.self) { selection in
                if (selection == "confirm") {
                    PinConfirmationView(username: email, isPresented: $isShowingRegistration)
                }
            }
        }
    }
    
    func didDismiss() {
        // Handle dismissed sheet
    }
}

#Preview {
    RegisterView(email: "krupp@case.edu", isShowingRegistration: .constant(true))
}
