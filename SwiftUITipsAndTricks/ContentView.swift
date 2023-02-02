//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

enum Days {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    
    var name: String {
        switch self {
        case .mon:
            return "Monday"
        case .tue:
            return "Tuesday"
        case .wed:
            return "Wednesday"
        case .thu:
            return "Thusrday"
        case .fri:
            return "Friday"
        case .sat:
            return "Saturday"
        case .sun:
            return "Sunday"
        }
    }
    
    var fullDescription: String {
        var description = ""
        switch self {
        case .mon, .tue, .wed, .thu, .fri:
            description = "Working day: "
            fallthrough
        default:
            description += self.name
        }
        return description
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text(Days.sun.fullDescription)
            Text(Days.mon.fullDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
