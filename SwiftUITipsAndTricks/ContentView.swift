//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

let response = """
{ "items": [
    {"name": "video1", "type": "video", "length": "1:25:00"},
    {"name": "video2", "type": "video", "length": "0:05:10"},
    {"name": "image1", "type": "image", "size": 2048},
    {"name": "image2", "type": "image", "size": 4096}
]}
""".data(using: .utf8)!

enum MultimediaType: String, Decodable {
    case video
    case image
}

protocol MultimediaItem {
    var name: String { get }
    var type: MultimediaType { get }
}

struct Video {
    let name: String
    let type: MultimediaType
    let length: String
}

struct Image {
    let name: String
    let type: MultimediaType
    let size: Int

}

struct MultimediaItems {
    let videos: [Video]
    let images: [Image]
}

struct UnexpectedNilProperty: Error {
    let propertyName: String
}

func unwrap<T>(property: T?, propertyName: String) throws -> T {
    if let property {
        return property
    } else {
        throw UnexpectedNilProperty(propertyName: propertyName)
    }
}

extension MultimediaItems: Decodable {
    
    struct DecodableMultimediaItem: Decodable {
        let name: String
        let type: MultimediaType
        let length: String?
        let size: Int?
    }
    
    struct DecodableMultimediaItems: Decodable {
        let items: [DecodableMultimediaItem]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodableItems = try container.decode(DecodableMultimediaItems.self)
        
        videos = try decodableItems.items
            .filter { $0.type == .video }
            .map { item in
                Video(name: item.name,
                      type: item.type,
                      length: try unwrap(property: item.length, propertyName: "lenght"))
            }
        
        images = try decodableItems.items
            .filter { $0.type == .image }
            .map { item in
                Image(name: item.name,
                      type: item.type,
                      size: try unwrap(property: item.size, propertyName: "size"))
            }
    }
}

struct ContentView: View {
    
    private let items: MultimediaItems
    init() {
        items = Self.buildItems()
    }
    
    var body: some View {
        
        List {
            Section("Videos") {
                ForEach(items.videos, id: \.name) { video in
                    Text("Name: \(video.name), lenght: \(video.length)")
                }
            }
            Section("Images") {
                ForEach(items.images, id: \.name) { image in
                    Text("Name: \(image.name), size: \(image.size)")
                }
            }
        }
    }
    
    private static func buildItems() -> MultimediaItems {
        do {
            return try JSONDecoder().decode(MultimediaItems.self, from: response)
        } catch {
            return MultimediaItems(videos: [], images: [])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
