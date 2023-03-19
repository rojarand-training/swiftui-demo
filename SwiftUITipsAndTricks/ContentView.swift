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
        VStack(alignment: .leading) {
            EventHeader()
            Text((1...20).reduce("") { res, value in res + "Bla bla " })
                .font(.title3)
            ImagePlaceholder()
            Text((1...50).reduce("") { res, value in res + "Hello World, " })
            Spacer()
            EventInfoList()
        }.padding(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EventInfoList: View {
    var body: some View {
        HStack {
            EventInfo(systemName: "video.circle.fill", infoText: "Video call available")
            EventInfo(systemName: "video.circle.fill", infoText: "Files are attached")
            EventInfo(systemName: "video.circle.fill", infoText: "Invites enabled, 5 people maximum")
        }
    }
}

struct ImagePlaceholder: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
            Text("Image placeholder")
        }
    }
}

struct EventInfo: View {
    let systemName: String
    let infoText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color.gray)
            VStack {
                Image(systemName: systemName)
                Text(infoText)
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
}

struct EventHeader: View {
   
    var body: some View {
        HStack {
            CalendarBadge()
            VStack(alignment: .leading) {
                Text("Title title")
                    .font(.title3)
                Text("Subtitle subtitle")
                    .font(.caption2)
            }
        }
    }
}

struct CalendarBadge: View {
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.green)
                .background(Circle().foregroundColor(.white))
                .asBadge()
        }
    }
}

extension View {
    
    func asBadge(ratio: CGFloat = 0.8) -> some View {
        alignmentGuide(HorizontalAlignment.trailing) { viewDimensions in
            viewDimensions.width * ratio
        }
        .alignmentGuide(VerticalAlignment.top) { viewDimensions in
            viewDimensions.height - (viewDimensions.height) * ratio
        }
        
    }
}
