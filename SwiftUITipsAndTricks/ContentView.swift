//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

enum ButtonStyle {
    case success
    case failure
    case info
    
    var foregroundColor: Color {
        switch self {
        case .success:
            return .green
        case .failure:
            return .red
        case .info:
            return .blue
        }
    }
}

struct StyledButton: ViewModifier {
    let style: ButtonStyle
    
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(style.foregroundColor)
            .cornerRadius(10)
    }
}

extension View {
    func successButton() -> some View {
        return modifier(StyledButton(style: .success))
    }
    
    func failureButton() -> some View {
        return modifier(StyledButton(style: .failure))
    }
    
    func infoButton() -> some View {
        return modifier(StyledButton(style: .info))
    }
}

struct ContentView: View {

    var body: some View {
        
        VStack {
            Button { } label: {
                Text("Success").successButton()
            }
            Button { } label: {
                Text("Failure").failureButton()
            }
            Button { } label: {
                Text("Info").infoButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
