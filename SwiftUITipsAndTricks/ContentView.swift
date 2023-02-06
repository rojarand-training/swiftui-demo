//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct MyStruct: Codable {
    let str: String
    let date: Date
}

let json = """
{
"str": "Hello",
"date":"2023-02-06 13:12:59"
}
""".data(using: .utf8)!

struct ContentView: View {
    @State var date: String = ""
    var body: some View {
        VStack {
            Text("Dates: \(date)")
            
            Button("Parse using 'dateDecodingStrategy = .formatted(formatter)'") {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let myStruct = try! decoder.decode(MyStruct.self, from: json)
                date = "\(formatter.string(from: myStruct.date))"
            }
            
            Button("Parse using 'dateDecodingStrategy = .custom()'") {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .custom({ dcdr in
                    let strDate = try! dcdr.singleValueContainer().decode(String.self)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                    return formatter.date(from: strDate)!
                })
                let myStruct = try! decoder.decode(MyStruct.self, from: json)
                date = "\(formatter.string(from: myStruct.date))"
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
