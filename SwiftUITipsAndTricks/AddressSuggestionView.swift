//
//  AddressSuggestionView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 13/12/2023.
//

import SwiftUI
import Combine

struct AddressSuggestionView: View {
    
    @StateObject private var vm: AddressSuggestionViewModel
    
    @FocusState var isTownFocused: Bool
    @FocusState var isStreetFocused: Bool
    
    init(addressSuggestion: Binding<AddressSuggestion>) {
        self._vm = StateObject(wrappedValue:AddressSuggestionViewModel(addressSuggestion: addressSuggestion))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack (alignment: .leading) {
                TextField("Wpisz miasto", text: $vm.addressSuggestion.townCandidate)
                    .focused($isTownFocused)
                HStack {
                    Text("Wybrano: ")
                    Text(vm.addressSuggestion.selectedTownLocation?.friendlyName ?? "")
                }
            }
            .padding()
            .roundedBorder(style: .primary)
            
            VStack(alignment: .leading) {
                TextField("Wpisz ulicę", text: $vm.addressSuggestion.streetCandidate)
                    .focused($isStreetFocused)
                HStack {
                    Text("Wybrano: ")
                    Text(vm.addressSuggestion.selectedStreetLocation?.friendlyName ?? "")
                }
                HStack {
                    Text("Lat/Lng: ")
                    Text(vm.addressSuggestion.coordinateText)
                }
            }
            .padding()
            .roundedBorder(style: .primary)
            
            List(vm.locations) { location in
                Text(location.friendlyName)
                    .onTapGesture {
                        if self.isTownFocused {
                            vm.onTownLocationSelected(location)
                        } else {
                            vm.onStreetLocationSelected(location)
                        }
                    }
            }
        }
        .padding()
        .onDisappear {
            //self.addressSuggestion.townCandidate = vm.addressSuggestion.townCandidate
        }
    }
}

struct AddressSuggestion_Previews: PreviewProvider {
    static var previews: some View {
        TravelTimeView()
    }
}
