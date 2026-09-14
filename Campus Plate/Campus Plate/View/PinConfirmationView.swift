//
//  PinConfirmationView.swift
//  Campus Plate
//
//  Created by Tyler Powers on 3/18/26.
//

import SwiftUI

struct PinConfirmationView: View {
    let username:String
    @State var pin = ""
    @State private var isConfirming = false
    @State private var errorReceived = false
    @State private var invalidCodeReceived = false
    @Binding var isPresented:Bool
    
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
                            Text("Enter PIN")
                                .foregroundStyle(.white)
                                .font(.title2)
                            Spacer()
                        }
                        TextField("", text: $pin)
                            .cpTextField()
                            .keyboardType(.numberPad)
                        VStack {
  
                            Button("Verify PIN") {
                                withAnimation {
                                    isConfirming = true
                                    invalidCodeReceived = false
                                    errorReceived = false
                                }
                                Task {
                                    do {
                                        let response = try await UserModel.confirmUser(username: username, pin: pin)
                                        
                                        if (response.status == .success) {
                                            if let credential = response.data?.GUID {
                                                let result = KeychainCredentialManager.saveCredential(credential: KeychainCredential(username: username, password: credential))
                                                if result {
                                                    isPresented = false
                                                }
                                                else {
                                                    errorReceived.toggle()
                                                }
                                            }
                                        }
                                        else if (response.status == .invalidMatch) {
                                            withAnimation {
                                                invalidCodeReceived = true
                                            }
                                        }
                                    }
                                    catch {
                                        print(error)
                                    }
                                    isConfirming = false
                                }

                            }
                            
                            .disabled(pin.isEmpty || isConfirming)
                            .buttonStyle(CPButtonStyle())
                            if isConfirming {
                                withAnimation {
                                    ProgressView()
                                }
                            }
                            
                        }
                        if invalidCodeReceived {
                            Text("The PIN that you provided is invalid. Please try again.")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        else if errorReceived {
                            Text("Unable to confirm your PIN at this time. Please try again.")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("The PIN is sent to the email that you provided. Please check your Junk or Clutter folder.")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }.padding()
                    Spacer(minLength: 60)
                }
            }
            .padding()
        }
        .background(.tint)
    }
}

#Preview {
    PinConfirmationView(username: "krupp@case.edu", pin: "423215", isPresented: .constant(true))
}
