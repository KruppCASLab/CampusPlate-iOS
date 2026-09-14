//
//  ContentView.swift
//  Campus Plate
//
//  Created by Brian Krupp on 1/15/26.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingRegistration = false
    var body: some View {
        ItemsView()
            .sheet(isPresented: $isShowingRegistration, content: {
                RegisterView(isShowingRegistration: $isShowingRegistration)
                    .interactiveDismissDisabled()
            })
            .task {
                if let credentail = KeychainCredentialManager.getCredential() {
                    print(credentail)
                }
                else {
                    isShowingRegistration = true
                }
            }
            
    }
}

#Preview {
    ContentView()
}
