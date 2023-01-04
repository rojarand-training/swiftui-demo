//
//  Scaffolding.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation
import SwiftUI

struct Scaffolding<L:AsyncLoadable, V:View>: View {

    typealias Loading = () async -> Void
    private let loadedView: (L.LoadResultType, @escaping Loading) -> V
    private let loadable: L
    @State private var loadState: LoadingState<L.LoadResultType>  = .neverLoaded
    
    init(_ loadable: L, loadedView: @escaping (L.LoadResultType, @escaping Loading) -> V) {
        self.loadable = loadable
        self.loadedView = loadedView
    }
    
    var body: some View {
        switch loadState {
        case .neverLoaded:
            neverLoadedView()
        case .loading:
            loadingView()
        case .success(let result):
            loadedView(result, load)
        case .failure(let error):
            failureView(error)
        }
    }
    
    private func load() async {
        do {
            loadState = .loading
            loadState = .success(result: try await loadable.load())
        } catch {
            loadState = .failure(error: error)
        }
    }
    
    private func neverLoadedView() -> some View {
        Color(.gray).ignoresSafeArea().onAppear {
            Task {
                await load()
            }
        }
    }
    
    @ViewBuilder private func failureView(_ error: Error) -> some View {
        let presentableError = error.asPresentableError
        if presentableError.critical {
            criticalFailureView(presentableError)
        } else if let defaultResult = L.LoadResultType.self as? Defautable.Type {
            bannerErrorView(defaultResult.init() as! L.LoadResultType, presentableError)
        } else {
            criticalFailureView(presentableError)
        }
    }
    
    private func criticalFailureView(_ error: PresentableError) -> some View {
        //ZStack {
        //    loadingView()
            ErrorView(error) {
                Task {
                    await load()
                }
            }
        //}
    }
    
    private func bannerErrorView(_ defaultResult: L.LoadResultType,
                                 _ error: PresentableError) -> some View {
        
        return ZStack {
            loadedView(defaultResult, load)
            BannerView(message: error.friendlyMessage)
        }
    }
}


