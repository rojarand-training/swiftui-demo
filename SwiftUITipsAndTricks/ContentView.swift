//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let angle = Angle(degrees: 360.0/CGFloat(subviews.count)).radians
        let r = min(bounds.width, bounds.height)/2
        subviews.enumerated().forEach { index, subview in
            let angleDelta = CGFloat(index)*angle
            var dx = cos(angleDelta) * r * 0.95
            let dy = sin(angleDelta) * r * 0.95
            subview.place(at: CGPoint(x: bounds.midX+dx, y: bounds.midY+dy), anchor: .center, proposal: proposal)
        }
        
    }
}

struct ContentView: View {

    var body: some View {
        RadialLayout {
            Text("1")
            Text("2")
            Text("3")
            Text("4")
            Text("5")
            Text("6")
            Text("7")
            Text("8")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
