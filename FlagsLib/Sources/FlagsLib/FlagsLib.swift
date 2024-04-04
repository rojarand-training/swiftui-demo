// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class FlagsLib {
    public static func getFlagData(byCountryTag countryTag: String) -> Data? {
        guard let bundle = defaultBundle ?? localTestBundle else { return nil }
        guard let url = bundle.url(forResource: countryTag, withExtension: "png") else { return nil }
        return try? Data(contentsOf: url)
    }
    
    private static var defaultBundle: Bundle? {
        let bundlePath = Bundle(for: Self.self).bundlePath + "/FlagsLib_FlagsLib.bundle"
        return Bundle(path: bundlePath)
    }
    
    private static var localTestBundle: Bundle? {
        let bundlePath = Bundle(for: Self.self).bundlePath + "/../FlagsLib_FlagsLib.bundle"
        return Bundle(path: bundlePath)
    }
}
