//
//  MemoryGame.swift
//  Memorize
//
//  Created by Natalia MACARI on 30.11.20.
//

// MODEL

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var visitedCards: Array<Card>
    var score: Int = 0
    
    var indexOfTheOneAndOnlyFaceUpCard : Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp } .only //faceUpIndices
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card){
       
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched { //works only if chosenIndex is not nil
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[chosenIndex].wasFlipped += 1
                cards[potentialMatchIndex].wasFlipped += 1
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    self.score += 2
                }else if cards[chosenIndex].wasFlipped > 1 || cards[potentialMatchIndex].wasFlipped > 1 {
                    self.score -= 1
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                
            }
        }
    }
    
    mutating func newGame() {
        
        for index in cards.indices{
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        
        cards.shuffle()
        self.score = 0
        visitedCards.removeAll()
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        visitedCards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    


//    
//    mutating func addTheme(id: Int, name: String, emoji: Array<String>, color: String, numberOfCardsToShow: Int) {
//        themes.append(Theme(id: id, name: name, emoji: emoji, color: color, numberOfCardsToShow: emoji.count))
//    }
//


    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var wasFlipped: Int = 0
    }
    

}
