//
//  ItemsView.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/14/26.
//

import SwiftUI
import MapKit

struct ItemsView: View {
    @State var isSheetPresented = false
    var body: some View {
        VStack {
            Map {
                Marker("Brian", coordinate: CLLocationCoordinate2D(latitude: 41.502183, longitude: -81.607837))
            }
            .mapStyle(.standard)
            .sheet(isPresented: $isSheetPresented) {
                    VStack {
                        Text("Food Listings")
                        
                        Spacer()
                        ItemsList()
                    }
                    .padding()
                    .presentationDetents([.fraction(0.2), .medium,  .large])
                        .interactiveDismissDisabled(true)
                        .presentationBackgroundInteraction(.enabled)
                }
            
        }
        
    }
}

#Preview {
    ItemsView()
}
