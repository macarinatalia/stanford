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
        VStack{
            HStack{
                Button("New Game", action: {
                    withAnimation(Animation.easeInOut){
                        viewModel.beginNewGame()
                    }
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
                CardView(card: card, themeColor: viewModel.theme.color ).onTapGesture{
                    withAnimation(.linear(duration: 0.5)){
                        viewModel.chooseCard(card: card)
                    }
                }
                    //.aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
               }
                .padding()
                .foregroundColor(viewModel.theme.color)
        }
    }
}


struct CardView: View{
    
    var card: MemoryGame<String>.Card
    var themeColor : Color
    
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animateBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched{
            ZStack{
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -animateBonusRemaining*360 - 90), clockwise: true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    } else{
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -card.bonusRemaining*360 - 90), clockwise: true)
                            
                    }
                }.padding(5).opacity(0.4)
                
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default )
            }
            .cardify(isFaceUp: card.isFaceUp, themeColor: self.themeColor)
            .transition(AnyTransition.scale)
            
        }
    }
    
    // MARK :- Drawing Constants
    
    private let fontScaleFactor : CGFloat = 0.7
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.chooseCard(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
