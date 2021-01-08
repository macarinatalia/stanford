//
//  Cardify.swift
//  Memorize
//
//  Created by Natalia MACARI on 07.01.21.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
        
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation}
        set { rotation = newValue }
    }
    
   // var themeColor: Color
    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
           
            }.opacity(isFaceUp ? 1 : 0)
                
                    RoundedRectangle(cornerRadius: cornerRadius).fill(
//                        LinearGradient(gradient: Gradient(colors: [themeColor.opacity(0.5), themeColor]),
//                                       startPoint: .topLeading,
//                                       endPoint: .bottomLeading)
                    ).opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation),axis: (0,1,0))
    }
    
    private let cornerRadius : CGFloat = 10.0
    private let edgeLineWidth : CGFloat = 3
}

extension View{
    func cardify(isFaceUp: Bool, themeColor: Color) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))//, themeColor: themeColor))
    }
    
}

