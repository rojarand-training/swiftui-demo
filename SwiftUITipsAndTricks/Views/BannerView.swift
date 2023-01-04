//
//  BannerView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 05/01/2023.
//

import Foundation
import SwiftUI

struct BannerView: View {
    let message: String
    @State private var visible: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "exclamationmark.circle.fill")
                Text("An error occured")
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Text(message)
                .font(.body)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))

        }
        .frame(width: viewWidth, height: viewHeight)
        .foregroundColor(.white)
        .background(.red)
        .cornerRadius(10)
        .offset(y: visible ? visibleOffsetY : hiddenOffsetY)
        .onAppear {
            Task {
                withAnimation(.easeOut(duration: 0.6)) {
                    visible = true
                }
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                withAnimation(.easeIn(duration: 1)) {
                    visible = false
                }
            }
        }
    }
    
    private var viewWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    private var viewHeight: CGFloat {
        max(UIScreen.main.bounds.height/10, 100)
    }
    
    private var visibleOffsetY: CGFloat {
        UIScreen.main.bounds.height/2 - (viewHeight/2) - 50
    }
    
    private var hiddenOffsetY: CGFloat {
        UIScreen.main.bounds.height/2 + (viewHeight/2) + 50
    }
}
