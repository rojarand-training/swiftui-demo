//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct CircleWithoutViewBuilder<Content: View>: View {
    var content: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Circle().foregroundColor(.blue)
            content()
        }
    }
}

struct CircleWithViewBuilder<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Circle().foregroundColor(.red)
            content()
        }
    }
}

struct CircleWithInlinedViewBuilder<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            Circle().foregroundColor(.red)
            content()
        }
    }
}


struct ContentView: View {
    var condition: Bool = true
    
    /*
     Error: Function declares an opaque return type 'some View', but the return statements in its body do not have matching underlying types
    func sampleView(aCondition: Bool) -> some View {
        if aCondition {
            return Text("A condition fullfiled")
        } else {
            return EmptyView()
        }
    }*/
    
    @ViewBuilder
    func sampleView(aCondition: Bool) -> some View {
        if aCondition {
            Text("A text created by a function")
        } else {
            EmptyView()
        }
    }
    
    var body: some View {
        VStack {
            
            sampleView(aCondition: true)
            
            CircleWithoutViewBuilder {
                Text("I'm compiling")
            }
            /* Multiple nested views
             Error: Type '()' cannot conform to 'View'
             CircleWithoutViewBuilder {
                Text("I'm first view")
                Text("I'm second view")
            }*/
            
            /* Conditions
             Error: Type '()' cannot conform to 'View'
            CircleWithoutViewBuilder {
                if condition {
                    Text("I'm compilling")
                } else {
                    Color(.blue)
                }
            }*/
           
            //Multiple nested views
            CircleWithViewBuilder {
                Rectangle()
                    .frame(width: 150, height: 50)
                    .foregroundColor(.gray)
                Text("I'm a text view")
            }
            
            //Multiple nested views
            CircleWithInlinedViewBuilder {
                if condition {
                    Text("I'm a text view")
                } else {
                    EmptyView()
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
