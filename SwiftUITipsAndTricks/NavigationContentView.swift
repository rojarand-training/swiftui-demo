//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class CounterVM: ObservableObject {
    @Published var counter = 0
    
    init() {
        print("View Model initialized")
    }
    
    func incrementCounter() {
        counter += 1
    }
}

struct InnerViewWithObservedVM: View {
    @ObservedObject var vm = CounterVM()
    
    init() {
        print("InnerViewWithObservedVM initialized")
    }
    
    var body: some View {
        Text("I'am the view with @Observed vm, counter: \(vm.counter)")
        Button("Increment counter", action: {
            vm.incrementCounter()
        })
        .onAppear {
            print("onAppear@InnerViewWithObservedVM")
        }.onDisappear {
            print("onDisappear@InnerViewWithObservedVM")
        }
    }
}

struct InnerViewWithStateVM: View {
    @StateObject var vm = CounterVM()
    
    init() {
        print("InnerViewWithStateVM initialized")
    }
    
    var body: some View {
        Text("I'am the view with @StateObject vm, counter: \(vm.counter)")
        Button("Increment counter", action: {
            vm.incrementCounter()
        })
        .onAppear {
            print("onAppear@InnerViewWithStateVM")
        }.onDisappear {
            print("onDisappear@InnerViewWithStateVM")
        }
    }
}

struct RefreshableContentView: View {
    
    @State var counter = 0
    var body: some View {
        
        VStack {
            Text("Counter: \(counter)")
            Button("Inc couter") {
                counter += 1
            }
            VStack {
                InnerViewWithStateVM()
                InnerViewWithObservedVM()
            }
        }.onAppear {
            print("onAppear@RefreshableContentView")
        }.onDisappear {
            print("onDisappear@RefreshableContentView")
        }
    }
}


struct NavigationContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Go to the view with @StateObject vm") {
                    InnerViewWithStateVM()
                }
                NavigationLink("Go to the view with @ObservedObject vm") {
                    InnerViewWithObservedVM()
                }
            }
        }.onAppear {
            print("onAppear@NavigationContentView")
        }.onDisappear {
            print("onDisappear@NavigationContentView")
        }
    }
}

struct ContentView: View {
    var body: some View {
        //RefreshableContentView()
        NavigationContentView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableContentView()
    }
}
