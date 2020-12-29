//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Natalia MACARI on 30.11.20.
//

//VM

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme : Theme
    
    init(){
        self.theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: self.theme)
        
    }
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String>{
        let emoji = theme.emoji.shuffled()
        let numberOfPairs = (theme.numberOfCardsToShow != nil ? theme.numberOfCardsToShow : Int.random(in: 2..<theme.emoji.count))!
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs, cardContentFactory: {pairIndex in
            return emoji[pairIndex]
        } )
    }
    
        
    
    //MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    

    //MARK: - Intents
    func chooseCard(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func beginNewGame(){
        self.theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: self.theme)
    }
    
    

    
    
}


