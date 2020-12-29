## Assignment 2

##### Task 1-2. Check if assingment 1 is done.

##### Task 3. Architect the concept of a “theme” into your game. A theme consists of a name for the theme, a set of emoji to use, a number of cards to show (which, for at least one, but not all themes, should be random), and an appropriate color to use to draw (e.g. orange would be appropriate for a Halloween theme). 

```swift
// GameTheme.swift

struct Theme : Identifiable {
    var id: Int
    var name: String
    var emoji: Array<String>
    var color: Color
    var numberOfCardsToShow: Int?
}
```

##### Task 4. Support at least 6 different themes in your game. 

```swift
// GameTheme.swift

let animals = Theme(id: 0, name: "Animals", emoji: ["🐶","🦊","🐸","🐤","🐙"], color: .red, numberOfCardsToShow: 5)
let smiles = Theme(id: 1, name: "Smiles", emoji:  ["😎","🥶","🥰","😀","👿","🤡"], color: .yellow, numberOfCardsToShow: 6)
let sport = Theme(id: 2, name: "Sport", emoji: ["🏀", "⚽️","🏓","🧘🏻‍♂️","🪁","🏇🏽"], color: .green)
let flags = Theme(id: 3, name: "Flags", emoji: ["🇦🇹", "🇦🇩", "🇧🇪", "🇧🇷", "🇬🇧", "🇬🇷", "🇨🇦", "🇬🇪", "🇩🇪", "🇱🇷"], color: .gray, numberOfCardsToShow: 9)
let balls = Theme(id: 4, name: "Balls", emoji: ["⚽️", "🏀", "🎱", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"], color: .gray, numberOfCardsToShow: 9)
let food = Theme(id: 5, name: "Food", emoji: ["🍓", "🥑", "🥖", "🌽", "🧄", "🍔", "🥐", "🍩", "🍭", "🎂"], color: .gray, numberOfCardsToShow: 10)

var themes = [animals, smiles, sport, flags, balls, food]
```


##### Task 5. A new theme should be able to be added to your game with a single line of code. 

```swift
//ViewModel

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
```

##### Task 6. Add a “New Game” button to your UI which begins a brand new game. This new game should have a randomly chosen theme.

```swift
// View

Button("New Game", action: {
            viewModel.beginNewGame()
    }).frame(width: 100, height: 40, alignment: .center)
        .padding(4.0)
        .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.blue, lineWidth: 2.0))


// ViewModel

func beginNewGame(){
    self.theme = Theme.themes.randomElement()!
    model = EmojiMemoryGame.createMemoryGame(with: self.theme)
}
```


##### Task 7. Show the theme’s name somewhere in your UI. 

```swift
// View

let themeName: String = viewModel.theme.name
Text("\(themeName)")
    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    .padding(10)
```

##### Task 8. Keep score in your game by giving 2 points for every match and penalizing 1 point for every previously seen card that is involved in a mismatch.

```swift
// Model

var score: Int = 0

struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
    var id: Int
    var wasFlipped: Int = 0
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
```

##### Task 9. Display the score in your UI

```swift
// View

let score: Int = viewModel.score
Text("\(score)")
    .frame(width: 50, height: 40, alignment: .center)
    .padding(10)


// ViewModel

var score: Int {
    model.score
}
```

##### Extra Credit 1. Support a gradient as the “color” for a theme.
 * Add new property themeColor to CardView 
 * Use  `LinearGradient()` inside `fill()` when the card is drawing
 
 ```swift
 // View
 
 Grid(viewModel.cards){ card in
     CardView(card: card, themeColor: viewModel.theme.color ).onTapGesture(perform: {
             viewModel.chooseCard(card: card)
         })
         .padding(5)
    }
     .padding()
     .foregroundColor(viewModel.theme.color)
     
     //...
     
struct CardView: View{
         
         var card: MemoryGame<String>.Card
         var themeColor : Color
         
         var body: some View{
         
         //...
             if !card.isMatched {
                 RoundedRectangle(cornerRadius: cornerRadius).fill(
                     LinearGradient(gradient: Gradient(colors: [themeColor.opacity(0.5), themeColor]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomLeading)
                 )
             }
         //...    
 ```
 
 ##### Screenshots
 
 <img src="Screenshots\assignment2_1.png" width="auto" height="auto">
 <img src="Screenshots\assignment2_2.png" width="auto" height="auto">
