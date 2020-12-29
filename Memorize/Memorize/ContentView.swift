//
//  ContentView.swift
//  Memorize
//
//  Created by Natalia MACARI on 27.11.20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel = EmojiMemoryGame()
    var body: some View {
       
        let fontSize = viewModel.cards.count/2 == 5 ? Font.footnote : Font.largeTitle
       
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card ).onTapGesture(perform: {
                    viewModel.chooseCard(card: card)
                })
           }
        }

            .padding()
            .foregroundColor(.orange)
            .font(fontSize)
            .aspectRatio(0.67, contentMode: .fit)
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        ZStack{
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: 5.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 5.0).stroke(lineWidth: 5)
                Text(card.content)
            } else{
                RoundedRectangle(cornerRadius: 5.0).fill()
            }
            
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
