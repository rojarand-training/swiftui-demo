//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var longitude = 0.0
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .frame(width: 400, height: 300)
            Slider(value: $longitude)
                .onChange(of: longitude) { newValue in
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: newValue), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
