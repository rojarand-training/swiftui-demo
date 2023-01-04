//
//  Loading.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation

enum LoadingState<LoadResultType> {
    case neverLoaded
    case loading
    case success(result: LoadResultType)
    case failure(error: Error)
}

protocol AsyncLoadable {
    associatedtype LoadResultType
    func load() async throws -> LoadResultType
}

protocol Loadable: ObservableObject {
    associatedtype LoadResultType
    var state: LoadingState<LoadResultType> { get }
    func load()
}
