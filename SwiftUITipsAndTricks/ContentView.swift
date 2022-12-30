//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            VStack {
                Text("frame(width: 60, height: 30)")
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 60, height: 30)
                    .background(.red)
            }.padding(.bottom, 10)
            VStack {
                Text("scaledToFit")
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 30)
                    .background(.red)
            }.padding(.bottom, 10)
            VStack {
                Text("scaledToFill")
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 30)
                    .background(.red)
            }.padding(.bottom, 10)

            VStack {
                VStack {
                    Text("aspectRatio(1.5, contentMode: .fit)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(1.5, contentMode: .fit)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)
                
                VStack {
                    Text("aspectRatio(1.0, contentMode: .fit)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)
                
                VStack {
                    Text("aspectRatio(0.5, contentMode: .fit)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(0.5, contentMode: .fit)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)
            }.background(.yellow)
            
            VStack {
                VStack {
                    Text("aspectRatio(1.5, contentMode: .fill)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(1.5, contentMode: .fill)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)
                
                VStack {
                    Text("aspectRatio(1.0, contentMode: .fill)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)

                VStack {
                    Text("aspectRatio(0.5, contentMode: .fill)")
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(0.5, contentMode: .fill)
                        .frame(width: 60, height: 30)
                        .background(.red)
                }.padding(.bottom, 10)
            }.background(.orange)


            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
