//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

extension View {
    
    func alignAsBadge(withRatio ratio: CGFloat = 0.8,
                      alignment: Alignment = .topTrailing) -> some View {
        alignmentGuide(alignment.horizontal) { viewDimensions in
            viewDimensions.width * ratio
        }
        .alignmentGuide(alignment.vertical) { viewDimensions in
            //viewDimensions.height * (1.0 - ratio)
            viewDimensions[.bottom] - viewDimensions.height * ratio
        }
    }
}

struct BadgedView: View {
    
    let imageSytemName: String
    let alignment: Alignment
    let ratio: CGFloat
    
    init(imageSytemName: String,
         alignment: Alignment = .topTrailing,
         ratio: CGFloat = 0.8
    ) {
        self.imageSytemName = imageSytemName
        self.alignment = alignment
        self.ratio = ratio
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            Image(systemName: imageSytemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 40)
                .foregroundColor(.gray)
            
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFit()
                .foregroundColor(.green)
                .background(
                    Circle()
                    .foregroundColor(.white)
                )
                .alignAsBadge(withRatio: ratio, alignment: alignment)
        }
    }
}

struct ContentView: View {

    var body: some View {
        VStack {
            VStack {
                Text("Ratio 1.0")
                BadgedView(imageSytemName: "engine.combustion",
                           alignment: .topTrailing, ratio: 1.0)
            }
            .padding()
            .background(.yellow)
            
            VStack {
                Text("Ratio 0.0")
                BadgedView(imageSytemName: "engine.combustion",
                           alignment: .topTrailing, ratio: 0.0)
            }
            .padding()
            .background(.orange)
            

            VStack {
                Text("Ratio -1.0")
                BadgedView(imageSytemName: "engine.combustion",
                           alignment: .topTrailing, ratio: -1.0)
                
            }
            .padding()
            .background(.red)

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
