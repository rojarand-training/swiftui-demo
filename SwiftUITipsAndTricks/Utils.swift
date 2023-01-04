//
//  Utils.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation
import SwiftUI

struct UnexpectedIntError: Error {
    let value: Int
}

extension UnexpectedIntError: PresentableError {
    var friendlyMessage: String {
        return "Unexcpected int error: \(value)"
    }
    
    var critical: Bool {
        return value>100
    }
}

protocol Defautable {
    init()
}

extension String: Defautable {
    init() {
        self.init("Co za lipa")
    }
}

struct StringLoader: AsyncLoadable {
    func load() async throws -> String {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let random = Int.random(in: 96...120)
        if random%2 == 0 {
            throw UnexpectedIntError(value: random)
        }
        return "\(random)"
    }
}

@ViewBuilder func loadingView() -> some View {
    ZStack {
        Color(.systemBackground)
            .opacity(0.65)
            .ignoresSafeArea()
        
        ProgressView()
            .scaleEffect(3)
            .padding(.top, -10)
    }
}

