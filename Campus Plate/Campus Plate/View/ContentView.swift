//
//  ContentView.swift
//  Campus Plate
//
//  Created by Brian Krupp on 1/15/26.
//

import SwiftUI

func shouldShowRegister() -> Bool {
    if let credential = KeychainCredentialManager.getCredential() {
        // Setup Session
        do {
            try Session.shared.configure(credential: credential)
            return false
        }
        catch {
            return true
        }
    }
    return true
}

struct ContentView: View {
    @State var isShowingRegistration = false
    @State var initialCheckCompleted = false
    
    var body: some View {
        VStack {
            if !isShowingRegistration && initialCheckCompleted {
                ItemsView(isSheetPresented: true)
            }
        }
        .fullScreenCover(isPresented: $isShowingRegistration, content: {
            RegisterView(isShowingRegistration: $isShowingRegistration)
                    .interactiveDismissDisabled()
        })
        .task {
            if shouldShowRegister() {
                isShowingRegistration = true
                initialCheckCompleted = true
            }
        }

    }
}

#Preview {
    ContentView()
}
