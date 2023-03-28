//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension BidirectionalCollection {
    
    func page(withIndex index: Int, size: Int) -> SubSequence {
        dropFirst(index*size).prefix(size)
    }
}

struct Numbers {
    let content = (1...10).map { $0 }
    
    func first(_ count: Int) -> ArraySlice<Int> {
        content.prefix(count)
        
    }
    func last(_ count: Int) -> ArraySlice<Int> {
        content.suffix(count)
    }
    
    func first(where conditionMet:(Int) -> Bool) -> ArraySlice<Int> {
        content.prefix(while: conditionMet)
    }
    
    func page(withIndex index: Int, size: Int) -> ArraySlice<Int> {
        content.page(withIndex: index, size: size)
    }
}

extension ArraySlice {
    var content: String {
        let elements = reduce("") { partialResult, element in
            if !partialResult.isEmpty {
                return partialResult + ", \(element)"
            } else {
                return "\(element)"
            }
        }
        return "[\(elements)]"
    }
}

struct ContentView: View {

    let numbers = Numbers()
    
    var body: some View {
        VStack {
            Text("First 100: \(numbers.first(100).content)")
            Text("Last 3: \(numbers.last(3).content)")
            Text("Less than 5: \(numbers.first{ $0 <= 5 }.content)")
            Text("Page with index:2, size:3 \(numbers.page(withIndex:2, size: 3).content)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
