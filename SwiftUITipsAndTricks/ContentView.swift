//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct GrouppingBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
        .border(.gray)
    }
}

extension View {
    func grouppingBorder() -> some View {
        self.modifier(GrouppingBorder())
    }
}


struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            GradientPresentationView()
        }
    }
}

struct GradientPresentationView: View {

    var body: some View {
        VStack {
            VStack {
                Text("Rectangle().fill(**Color.blue.gradient**)")
                Rectangle()
                    .fill(Color.blue.gradient)
                    .frame(width: 200, height: 50)
            }
            .grouppingBorder()
            
            VStack {
                Text("**LinearGradient**(colors: [.white, .red], startPoint: **.top**, endPoint: **.bottom**)")
                Text("Hello World")
                    .background(LinearGradient(colors: [.white, .red], startPoint: .top, endPoint: .bottom))
            }
            .grouppingBorder()
            
            VStack {
                Text("LinearGradient(colors: [.white, .red], startPoint: **.leading**, endPoint: **.trailing**)")
                Text("Hello World")
                    .background(LinearGradient(colors: [.white, .red], startPoint: .leading, endPoint: .trailing))
            }
            .grouppingBorder()

            VStack {
                Text("**LinearGradient**(colors: [.white, .red], startPoint: **.leading**, endPoint: **.trailing**)")
                Circle()
                    .fill(LinearGradient(colors: [.white, .red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 50)
            }
            .grouppingBorder()
            
            VStack {
                Text("**RadialGradient**(colors: [.white, .orange, .green], center: .center, startRadius: 0, endRadius: frame.width/2)")
                Circle()
                    .fill(RadialGradient(colors: [.white, .orange, .green], center: .center, startRadius: 0, endRadius: 25))
                    .frame(width: 50)
            }
            .grouppingBorder()
            
            VStack {
                Text("RadialGradient(gradient: **Gradient**(colors: [.white, .orange, .green, .blue, .purple]), center: .center, startRadius: 10, endRadius: 50)")
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.white, .orange, .green, .blue, .purple]), center: .center, startRadius: 10, endRadius: 50))
                    .frame(width: 50)
            }
            .grouppingBorder()
            
            VStack {
                Text("**AngularGradient**(colors:[.blue, .orange, .green], center: .center, startAngle: .degrees(0.0), endAngle: .degrees(180.0))")
                Circle()
                    .fill(AngularGradient(colors:[.blue, .orange, .green], center: .center, startAngle: .degrees(0.0), endAngle: .degrees(180.0)))
                    .frame(width: 50)
            }
            .grouppingBorder()
             
            VStack {
                Text("""
                        ".**strokeBorder**(
                            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                            lineWidth: 15
                        )
                    """)
                Circle()
                    .strokeBorder(
                            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                            lineWidth: 10
                        )
                    .frame(width: 50, height: 50)
            }
            .grouppingBorder()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
