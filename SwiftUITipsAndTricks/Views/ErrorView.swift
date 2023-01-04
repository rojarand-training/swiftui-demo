//
//  ErrorView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation
import SwiftUI

protocol PresentableError {
    var friendlyMessage: String { get }
    var critical: Bool { get }
}

extension PresentableError {
    
    var friendlyMessage: String {
        return "Unknown error"
    }
    
    var critical: Bool {
        return true
    }
}

struct UnknownError: Error, PresentableError {
}


extension Error {
    var asPresentableError: PresentableError {
        self as? PresentableError ?? UnknownError()
    }
}

struct ErrorView: View {
    
    typealias Retrying = () -> Void
    let presentableError: PresentableError
    let retrying: Retrying
    @State private var visible: Bool = false
    
    init(_ presentableError: PresentableError, _ retrying: @escaping Retrying) {
        self.presentableError = presentableError
        self.retrying = retrying
        print("Creating error view with visibility: \(visible)")
    }
    
    var body: some View {
        ZStack {
            Color(.red)
                .ignoresSafeArea()
            VStack {
                Text("A Critical Error Occured")
                    .font(.largeTitle)
                Text(presentableError.friendlyMessage)
                    .foregroundColor(.white)
                    .padding(.top, 15)
                Button {
                    Task {
                        withAnimation(.easeIn(duration: 0.3)) {
                            visible = false
                        }
                        try? await Task.sleep(nanoseconds: 300_000_000)
                        retrying()
                    }
                } label: {
                    Text("Retry")
                        .padding()
                        .foregroundColor(.white)
                }

            }
        }
        .offset(y: visible ? 0 : UIScreen.main.bounds.height+10)
        .onAppear {
            print("On appear called: \(visible)")
            withAnimation(.easeIn(duration: 0.3)) {
                visible = true
            }
        }.onDisappear {
            print("ContentView disappeared!")
        }
    }
    
}
