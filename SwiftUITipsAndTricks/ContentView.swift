//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

typealias ColorUnit = CGFloat

extension ColorUnit {
    
}

struct RGBA {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}

extension RGBA {
    var lighter: RGBA {
        changeColor(by: 0.1)
    }
    var darker: RGBA {
        changeColor(by: -0.1)
    }
    
    private func changeColor(by componentDelta: CGFloat) -> RGBA {
        RGBA(red: Self.add(componentDelta: componentDelta, component: red),
             green: Self.add(componentDelta: componentDelta, component: green),
             blue: Self.add(componentDelta: componentDelta, component: blue),
             alpha: alpha)
    }
    
    private static func add(componentDelta: CGFloat, component: CGFloat) -> CGFloat {
        //between 0 and 1
        max(0, min(1, component+componentDelta))
    }
    
    var cgColor: CGColor {
        CGColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var uiColor: UIColor {
        UIColor(cgColor: cgColor)
    }
    

}

extension UIColor {
    var lighter: UIColor {
        rgba.lighter.uiColor
    }
    var darker: UIColor {
        rgba.darker.uiColor
    }
    
    private var rgba: RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        return RGBA(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CGColor {
    var lighter: CGColor {
        rgba.lighter.cgColor
    }
    var darker: CGColor {
        rgba.darker.cgColor
    }
    
    private var rgba: RGBA {
        guard let rgbaComponents = self.components, rgbaComponents.count==4 else {
            return RGBA(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return RGBA(red: rgbaComponents[0],
                    green: rgbaComponents[1],
                    blue: rgbaComponents[2],
                    alpha: rgbaComponents[3])
    }
}


struct ContentView: View {
    
    @State var cgColor = Self.defaultColor
    
    private static var defaultColor: CGColor {
        CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    var body: some View {
        VStack {
            Button("Make bg lighter") {
                cgColor = cgColor.lighter
            }
            Button("Make bg darker") {
                cgColor = cgColor.darker
            }
            Button("Reset") {
                cgColor = Self.defaultColor
            }
        }.background(Color(cgColor: cgColor))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
