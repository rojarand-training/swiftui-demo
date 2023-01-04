//
//  AsyncContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation
import SwiftUI


struct AsyncContentView<Loader: Loadable, Content: View>: View {
    @ObservedObject var loader: Loader
    let content: (Loader.LoadResultType) -> Content
    
    init(_ loader: Loader, @ViewBuilder content: @escaping (Loader.LoadResultType) -> Content) {
        self.loader = loader
        self.content = content
    }
    
    var body: some View {
        switch loader.state {
        case .neverLoaded:
            neverLoadedView()
        case .loading:
            loadingView()
        case .success(let result):
            content(result)
        case .failure(let error):
            failureView(error)
        }
    }
    
    private func neverLoadedView() -> some View {
        Color(.gray).ignoresSafeArea()
    }
    
    @ViewBuilder private func failureView(_ error: Error) -> some View {
        let presentableError = error.asPresentableError
        if presentableError.critical {
            criticalFailureView(presentableError)
        } else if let defaultResult = Loader.LoadResultType.self as? Defautable.Type {
            bannerErrorView(defaultResult.init() as! Loader.LoadResultType, presentableError)
        } else {
            criticalFailureView(presentableError)
        }
    }
    
    private func criticalFailureView(_ error: PresentableError) -> some View {
        return ErrorView(error) {
            loader.load()
        }
    }
    
    private func bannerErrorView(_ defaultResult: Loader.LoadResultType,
                                 _ error: PresentableError) -> some View {
        
        return ZStack {
            content(defaultResult)
            BannerView(message: error.friendlyMessage)
        }
    }
}