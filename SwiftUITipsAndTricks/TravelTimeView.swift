//
//  AddressSuggestion.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 11/12/2023.
//

import SwiftUI

enum BorderStyle {
    case warning
    case success
    case primary
}

struct NamedAddressSuggestion {
    @Binding var addressSuggestion: AddressSuggestion
    let name: String
}

extension NamedAddressSuggestion: Equatable {
    static func == (lhs: NamedAddressSuggestion, rhs: NamedAddressSuggestion) -> Bool {
        lhs.name == rhs.name
    }
}

extension NamedAddressSuggestion: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct TravelTimeView: View {
    
    @StateObject private var vm = TravelTimeViewModel()
    @FocusState var isStartStreetSelected: Bool
    @FocusState var isFinishTownSelected: Bool
    @FocusState var isFinishStreetSelected: Bool
    
    private var addressSuggestions: [NamedAddressSuggestion] {
        [
            NamedAddressSuggestion(addressSuggestion: $vm.startAddressSuggestion, name: "Wybierz adres początkowy"),
            NamedAddressSuggestion(addressSuggestion: $vm.finishAddressSuggestion, name: "Wybierz adres końcowy")
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                
                List(addressSuggestions, id: \.name) { address in
                    NavigationLink(value: address) {
                        VStack {
                            if let friendlyName = address.addressSuggestion.selectedStreetLocation?.friendlyName {
                                Text(friendlyName)
                                Text(address.addressSuggestion.coordinateText)
                            } else {
                                Text(address.name)
                            }
                        }
                    }
                }
                .navigationDestination(for: NamedAddressSuggestion.self) { namedAddressSuggestion in
                    AddressSuggestionView(addressSuggestion: namedAddressSuggestion.$addressSuggestion)
                }
                .frame(maxHeight: 180)
                                
                VStack(alignment: .center) {
                    HStack {
                        Text("Czas dojazdu: ")
                        Text(vm.travelTime)
                    }
                    .border(.blue)
                    Button("Oblicz czas dojazdu") {
                        vm.computeTravelTime()
                    }.disabled(!vm.isComputingTravelTimeAvailable)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                VStack {
                    TextField("Szerokość geograficzna (lat)", text: $vm.latitude)
                    TextField("Długość geograficzna (lon)", text: $vm.longitude)
                    Button("Przelicz lat/lng -> addres") {
                        vm.reverseGeocodeAddress()
                    }
                    Text(vm.reverseGeocodedAddress)
                }
                
                VStack {
                    Button("Oblicz czas dojazdu wielu taksówek") {
                        vm.computeMultipleTravelTime()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct TravelTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TravelTimeView()
    }
}

struct RoundedBorder: ViewModifier {
    let borderStyle: BorderStyle
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0)
                .stroke(borderColor, lineWidth: 2)
        )
    }
    
    private var borderColor: Color {
        switch borderStyle {
        case .warning:
                .yellow
        case .success:
                .green
        case .primary:
                .blue
        }
    }
}

extension View {
    func roundedBorder(style: BorderStyle) -> some View {
        self.modifier(RoundedBorder(borderStyle: style))
    }
}
