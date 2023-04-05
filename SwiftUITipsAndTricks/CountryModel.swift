//
//  CountryModel.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/04/2023.
//

import Foundation
import UIKit

struct FlagURLs: Decodable {
    let png: String
    let svg: String
    
    var bestURL: URL? {
        URL(string: png) ?? URL(string: svg)
    }
}

struct CountryNetworkModel: Decodable {
    let name: String
    let flags: FlagURLs
}

extension CountryNetworkModel {
    var flagURL: URL? {
        flags.bestURL
    }
}

typealias CountryNetworkModels = [CountryNetworkModel]

struct Country {
    let id: Int
    let name: String
    let flags: FlagURLs
}

extension Country {
    var flagURL: URL? {
        flags.bestURL
    }
}

typealias Countries = [Country]

struct CountryViewData {
    let name: String
    let flagData: Data?
    
    init(name: String, flagImageData: Data?) {
        self.name = name
        self.flagData = flagImageData
    }
}

typealias CountryViewsData = [CountryViewData]

