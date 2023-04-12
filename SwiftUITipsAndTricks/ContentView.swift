//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData



private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        
        static func reduce(value: inout CGPoint, nextValue: () -> Self.Value) {
            //nop
        }
    }
}

struct PositionObservingView<Content: View>: View {
   
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        content()
            .background(
                GeometryReader { reader in
                    Color.clear.preference(
                        key: Self.PreferenceKey.self,
                        value: reader.frame(in: coordinateSpace).origin)
                })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    
    @Binding var offset: CGPoint
    @ViewBuilder let content: () -> Content
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(get: {
                    offset
                }, set: { newOffset in
                    offset = CGPoint(x: -newOffset.x,
                                     y: -newOffset.y)
                }),
                content: content)
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

struct ContentView: View {

    @State var offset: CGPoint = .zero
    
    var body: some View {
        OffsetObservingScrollView(offset: Binding(get: {
            offset
        }, set: { newValue in
            offset = newValue
            print("Offset: \(offset.y)")
        }), content: {
            
            LazyVStack {
                ForEach((1..<100)) { int in
                    XXX(content: "Row: \(int)")
                }
            }
        }
        )
    }
}

struct XXX: View {
    private let content: String
    
    init(content: String) {
        //print("Creating view with: \(content)")
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .onAppear {
                //print("Appear: \(content)")
            }
            .onDisappear {
                //print("Disappear: \(content)")
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
