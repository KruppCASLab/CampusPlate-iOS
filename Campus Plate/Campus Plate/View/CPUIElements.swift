//
//  CPUIElements.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/4/26.
//

import SwiftUI


struct CPTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .clipShape(Capsule())
    }
}

extension View {
    func cpTextField() -> some View {
        modifier(CPTextField())
    }
}

struct CPButtonStyle:ButtonStyle {
    @SwiftUI.Environment(\.isEnabled) private var isEnabled:Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .foregroundStyle(.accent)
            .font(.title2)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .opacity(isEnabled ? 1.0 : 0.5)
        
    }
}

#Preview {
    RegisterView(email: "krupp@case.edu", isShowingRegistration: .constant(true))
//    Button("Hello") {
//        
//    }
//    .buttonStyle(CPButtonStyle())
//    .modifier(CPButton())
    
}
