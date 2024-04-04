//
//  American.swift
//  Pods
//
//  Created by Robert Andrzejczyk on 29/03/2024.
//

import Foundation

public final class PodFlags {
    
    public static func getResourcesData(byCountryTag countryTag: String) -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: countryTag, withExtension: "png", subdirectory: "Flags") else { return nil }
        return try? Data(contentsOf: url)
    }
    
    public static func getBundleData(byCountryTag countryTag: String) -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: countryTag, withExtension: "png", subdirectory: "ResourceBundlesPodFlagsLib2.bundle") else { return nil }
        return try? Data(contentsOf: url)
    }
}
