//
//  RegisterView.swift
//  Campus Plate
//
//  Created by Brian Krupp on 2/4/26.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    
    var body: some View {
        VStack {
            VStack(spacing:20) {
                Text("Campus Plate")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                Text("University Email")
                TextField("Email", text: $email)
                Button("Get Pin") {
                    // TODO: Task to call service
                }
                .buttonStyle(.borderedProminent)
               
            }.padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.tint)
    }
}

#Preview {
    RegisterView()
}
