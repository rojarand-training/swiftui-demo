//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct AnyVideo {
    let duration: TimeInterval
}

struct AnyPhoto {
    let sizeInBytes: UInt
}

//1. Store as 'Any'
let anyMedia: [Any] = [AnyVideo(duration: 1), AnyPhoto(sizeInBytes: 1)]

func printAnyMedia() {
    anyMedia.forEach { media in
        switch media {
        case let v as AnyVideo:
            print("Video length: \(v.duration)")
        case let p as AnyPhoto:
            print("Photo size: \(p.sizeInBytes)")
        default:
            print("Unknown type")
        }
    }
}


//2a. Store as 'Item' -> compilation error
/*
protocol Item: Identifiable {
    var title: String { get }
}

struct Video {
    let id: String
    let title: String
    let duration: TimeInterval
}

struct Photo {
    let id: String
    let title: String
    let sizeInBytes: UInt
}

extension Video: Item {
}

extension Photo: Item {
}
//error: Use of protocol 'Item' as a type must be written 'any Item'
let items: [Item] = [Video(id: "1", title: "1", duration: 1), Photo(id: "1", title: "1", sizeInBytes: 1)]
func printItems() {
    items.forEach { item in
        print("Item.title: \(item.title)")
    }
}*/


protocol AnyItem {
    var id: String { get }
    var title: String { get }
}

typealias Item = AnyItem & Identifiable

struct Video {
    let id: String
    let title: String
    let duration: TimeInterval
}

struct Photo {
    let id: String
    let title: String
    let sizeInBytes: UInt
}

extension Video: Item {
}

extension Photo: Item {
}
//2b. Store as 'AnyItem'
//Note -> trick: We can not to have Item here, but we can have AnyItem with all properties
let items: [AnyItem] = [Video(id: "1", title: "1", duration: 1), Photo(id: "1", title: "1", sizeInBytes: 1)]
func printItems() {
    items.forEach { item in
        print("Item.title: \(item.title)")
    }
}

func filterItems(withTitle title: String) -> [AnyItem] {
    items.filter{ item in item.title == title  }
}

//3
enum EItem {
    case video(Video)
    case photo(Photo)
}

let eitems: [EItem] = [.video(Video(id: "1", title: "1", duration: 1)), .photo(Photo(id: "1", title: "1", sizeInBytes: 1))]
func printEItems() {
    eitems.forEach { eItem in
        switch eItem {
        case .video(let video):
            print("Video duration: \(video.duration)")
        case .photo(let photo):
            print("Photo size: \(photo.sizeInBytes)")
        }
    }
}
 
struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Hello World")
            Button("Print any media") {
                printAnyMedia()
                print("---------------------------------------------------------------------")
                printItems()
                print("---------------------------------------------------------------------")
                printEItems()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
