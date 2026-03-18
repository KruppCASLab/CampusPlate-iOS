//
//  PinConfirmationView.swift
//  Campus Plate
//
//  Created by Tyler Powers on 3/18/26.
//

import SwiftUI

struct PinConfirmationView: View {
    @State var pin = ""
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
                            .background(.white)
                            .font(.title2)
                            .keyboardType(.numberPad)
                        Button("Verify PIN") {
                            // TODO: Task to call service
                            // Reject: dismiss the sheet
                            // Accept: Navigate to main map view
                        }
                        .foregroundStyle(.accent)
                        .font(.title3)
                        .buttonStyle(.borderedProminent)
                        .tint(.white)
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
    PinConfirmationView()
}
