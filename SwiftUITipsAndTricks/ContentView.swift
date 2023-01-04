//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import Combine

extension Publisher where Failure==Never {
    func weakAssign<T: AnyObject>(
        to kp: ReferenceWritableKeyPath<T, Output>,
        on object: T) -> AnyCancellable {
        
        sink { [weak object] value in
            object?[keyPath: kp] = value
        }
    }
}

class ContentViewModel: ObservableObject {
    
    @Published var currentDate: String = ""
    private var cancellables: AnyCancellable?
    
    func updateDate() {
        cancellables = Just<Date>(Date.now)
            .map{ "\($0)" }
            .weakAssign(to: \.currentDate, on: self)
    }
}

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Date: \(viewModel.currentDate)")
            Button("Update date") {
                viewModel.updateDate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
