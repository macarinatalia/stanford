//
//  ContentView.swift
//  Memorize
//
//  Created by Natalia MACARI on 27.11.20.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()
    
    
    var body: some View {

        HStack{
            
            Button("New Game", action: {
                        viewModel.beginNewGame()
                }).frame(width: 100, height: 40, alignment: .center)
                    .padding(4.0)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.blue, lineWidth: 2.0))
            
            let themeName: String = viewModel.theme.name
            Text("\(themeName)")
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(10)
            let score: Int = viewModel.score
            Text("\(score)")
                .frame(width: 50, height: 40, alignment: .center)
                .padding(10)
                .foregroundColor(viewModel.theme.color)
        }
        
        
        
        
        Grid(viewModel.cards){ card in
            CardView(card: card, themeColor: viewModel.theme.color ).onTapGesture(perform: {
                    viewModel.chooseCard(card: card)
                })//.aspectRatio(2/3, contentMode: .fit)
                .padding(5)
           }
        
            .padding()
            .foregroundColor(viewModel.theme.color)
    }
}


struct CardView: View{
    
    var card: MemoryGame<String>.Card
    var themeColor : Color
    
    var body: some View{
        
        GeometryReader{ geometry in
            
            ZStack{
                if card.isFaceUp{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else{
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(
                            LinearGradient(gradient: Gradient(colors: [themeColor.opacity(0.5), themeColor]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomLeading)
                        )
                    }
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
    
    // MARK :- Drawing Constants
    let cornerRadius : CGFloat = 10.0
    let edgeLineWidth : CGFloat = 3
    let fontScaleFactor : CGFloat = 0.75
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
