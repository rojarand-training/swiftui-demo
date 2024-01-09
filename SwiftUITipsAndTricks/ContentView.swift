//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var newNoteText = ""
    @State private var notes: [String]
    @State private var isPresented: Bool = false
    
    init() {
        notes = ["Note1", "Note2"]
    }
    
    var body: some View {
        NavigationStack {
            List(Array(notes.enumerated()), id: \.offset) { indexedNote in
                Text(indexedNote.element)
            }
            .toolbar(content: {
                Button(action: {
                    newNoteText = ""
                    isPresented = true
                }, label: {
                    Image(systemName: "plus")
                })
                .accessibilityIdentifier("addTaskButton")
            })
            .sheet(isPresented: $isPresented, content: {
                AddTaskView(isPresented: $isPresented, notes: $notes)
            })
        }
    }
}

struct AddTaskView: View {
    
    @Binding var isPresented: Bool
    @Binding var notes: [String]
    @State var note: String = ""
    
    init(isPresented: Binding<Bool>, notes: Binding<[String]>) {
        self._isPresented = isPresented
        self._notes = notes
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Type a note text", text: $note)
                Button("Add note") {
                    notes.append(note)
                    isPresented = false
                }
            }
            .padding()
            .navigationTitle("Add Task")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
