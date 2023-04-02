//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

enum Importance {
    case high
    case medium
    case low
}

struct Predicate<T> {
    let matching:(T) -> Bool
}

struct TODO {
    let description: String
    let importance: Importance
    let deadline: Date
}

extension Predicate where T == TODO {
    static func highlyImportant() -> Predicate {
        Predicate { todo in
            todo.importance == .high
        }
    }
    
    static func moderatelyImportant() -> Predicate {
        Predicate { todo in
            todo.importance == .medium
        }
    }
    
    static func notImportant() -> Predicate {
        Predicate { todo in
            todo.importance == .low
        }
    }
    
    static func overdue() -> Predicate {
        Predicate { todo in
            todo.deadline < Date()
        }
    }
}

extension Predicate {
    static func &&(lhs: Predicate, rhs: Predicate) -> Predicate {
        Predicate { todo in
            lhs.matching(todo) && rhs.matching(todo)
        }
    }
    static func ||(lhs: Predicate, rhs: Predicate) -> Predicate {
        Predicate { todo in
            lhs.matching(todo) || rhs.matching(todo)
        }
    }
}

extension Array where Element == TODO {
    func matching(_ predicate: Predicate<TODO>) -> [TODO] {
        self.filter { todo in
            predicate.matching(todo)
        }
    }
}

extension Date {
    init(hoursSinceNow: Int) {
        self.init(timeIntervalSinceNow: Double(hoursSinceNow) * 3600.0)
    }
}

final class ContentViewModel: ObservableObject {
    
    private let tasks = [
        TODO(description: "Do shopping", importance: .medium, deadline: .init(hoursSinceNow: 24)),
        TODO(description: "Call Marry", importance: .low, deadline: .init(hoursSinceNow: 48)),
        TODO(description: "Pay insurance", importance: .high, deadline: .init(hoursSinceNow: 48)),
        TODO(description: "Check party inviatations", importance: .high, deadline: .init(hoursSinceNow: -48)),
        TODO(description: "Visit Mark", importance: .high, deadline: .init(hoursSinceNow: -30)),
    ]
    
    @Published var overdueImportantTasks: [TODO]
    @Published var importantTasks: [TODO]
    @Published var moderatelyImportantTasks: [TODO]
    @Published var notImportantTasks: [TODO]
    @Published var overdueOrNotImportantTasks: [TODO]
    
    init() {
        overdueImportantTasks = tasks.matching(.highlyImportant() && .overdue())
        importantTasks = tasks.matching(.highlyImportant())
        moderatelyImportantTasks = tasks.matching(.moderatelyImportant())
        notImportantTasks = tasks.matching(.notImportant())
        overdueOrNotImportantTasks = tasks.matching(.overdue() || .notImportant())
    }
    
}

struct ContentView: View {
    
    @StateObject private var vw = ContentViewModel()
    
    var body: some View {
        List {
            Section("Highly important overdue tasks") {
                ForEach(vw.overdueImportantTasks, id: \.description) { todo in
                    Text(todo.description)
                }
            }
            Section("Highly important tasks") {
                ForEach(vw.importantTasks, id: \.description) { todo in
                    Text(todo.description)
                }
            }
            Section("Moderately important") {
                ForEach(vw.moderatelyImportantTasks, id: \.description) { todo in
                    Text(todo.description)
                }
            }
            Section("Not important") {
                ForEach(vw.notImportantTasks, id: \.description) { todo in
                    Text(todo.description)
                }
            }
            Section("Not important or overdue") {
                ForEach(vw.overdueOrNotImportantTasks, id: \.description) { todo in
                    Text(todo.description)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
