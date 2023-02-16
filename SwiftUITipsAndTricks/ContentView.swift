//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

let response = """
[
    {"name": "video1", "type": "videoType", "length": "1:25:00"},
    {"name": "video2", "type": "videoType", "length": "0:05:10"},
    {"name": "image1", "type": "imageType", "size": 2048},
    {"name": "image2", "type": "imageType", "size": 4096}
]
""".data(using: .utf8)!

enum ItemVariantType: String, Decodable {
    case videoType
    case imageType
}

protocol ItemVariant: Decodable {
    var name: String { get }
    var type: ItemVariantType { get }
}

struct Video: ItemVariant {
    let name: String
    let length: String
    var type: ItemVariantType {
        .videoType
    }
}

struct Image: ItemVariant {
    let name: String
    let size: Int
    var type: ItemVariantType {
        .imageType
    }
}

enum Item {
    case video(Video)
    case image(Image)
}

extension Item: Decodable {
    enum Properties: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Properties.self)
        let type = try container.decode(ItemVariantType.self, forKey: .type)
        switch type {
        case .imageType:
            self = .image(try Image(from: decoder))
        case .videoType:
            self = .video(try Video(from: decoder))
        }
    }
}

extension Array where Element==Item {
    var videos: [Video] {
        self.compactMap { item in
            if case Item.video(let video) = item {
                return video
            } else {
                return nil
            }
        }
    }
    
    var images: [Image] {
        self.compactMap { item in
            if case Item.image(let image) = item {
                return image
            } else {
                return nil
            }
        }
    }
}

struct ContentView: View {
    
    let items: [Item]
    
    init() {
        self.items = Self.loadItems()
    }
    
    var body: some View {
        List {
            Section("Videos") {
                ForEach(items.videos, id: \.name) { video in
                    Text("Name: \(video.name), length: \(video.length)")
                }
            }
            Section("Images") {
                ForEach(items.images, id: \.name) { image in
                    Text("Name: \(image.name), size: \(image.size)")
                }
            }
        }
    }
    
    private static func loadItems() -> [Item] {
        do {
            return try JSONDecoder().decode([Item].self, from: response)
        } catch  {
            return []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
